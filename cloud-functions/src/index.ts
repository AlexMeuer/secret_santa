/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as logger from "firebase-functions/logger";
import { defineSecret, defineString } from "firebase-functions/params";
import { onRequest } from "firebase-functions/v2/https";
import * as formData from "form-data";
import Mailgun from "mailgun.js";
import { z } from "zod";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const DOMAIN = defineString("DOMAIN");
const AUTHOR_NAME = defineString("AUTHOR_NAME");
const AUTHOR_WEBSITE = defineString("AUTHOR_WEBSITE");
const MAILGUN_API_KEY = defineSecret("MAILGUN_API_KEY");
const MAILGUN_URL = defineString("MAILGUN_URL");
const MAILGUN_TEMPLATE = defineString("MAILGUN_TEMPLATE");
const MAIL_FROM = defineString("MAIL_FROM");

const Participant = z.object({
	name: z.string().min(1),
	email: z.string().email(),
});
type Participant = z.infer<typeof Participant>;

const Payload = z.object({
	participants: z.array(Participant).min(2),
});
type Payload = z.infer<typeof Payload>;

export const doSecretSantaDraw = onRequest(
	{ cors: DOMAIN.value() },
	// { cors: true }, // Allows all CORS requests, do not use in production.
	async (request, response) => {
		if (request.method !== "POST") {
			response.status(405).send("Method Not Allowed");
			return;
		}

		const parseResult = Payload.safeParse(request.body);
		if (!parseResult.success) {
			response.status(422).send(parseResult.error);
			return;
		}

		const { participants } = parseResult.data;

		// Check if there are any duplicates in the list of participants
		if (hasDuplicates(participants)) {
			response.status(419).send("Duplicate participants are not allowed");
			return;
		}

		// Clone the array of participants
		const assignees = participants.slice();

		// Is anyone assigned to themselves?
		// (Assumes arrays will be mutated in place)
		const hasSelfAssignment = () => {
			return assignees.some((participant, index) => {
				return participant.email === participants[index].email;
			});
		};

		while (hasSelfAssignment()) {
			// Shuffle the array
			assignees.sort(() => Math.random() - 0.5);
		}

		const mailgun = new Mailgun(formData);
		const mg = mailgun.client({
			username: "api",
			key: MAILGUN_API_KEY.value(),
			url: MAILGUN_URL.value(),
		});

		const errors: string[] = [];
		for (let index = 0; index < participants.length; index++) {
			try {
				const result = await mg.messages.create(DOMAIN.value(), {
					from: `Santa <${MAIL_FROM.value()}>`,
					to: [participants[index].email],
					subject: "Secret Santa Draw",
					template: MAILGUN_TEMPLATE.value(),
					"h:X-Mailgun-Variables": {
						RECIPIENT_NAME: participants[index].name,
						ASSIGNEE_NAME: assignees[index].name,
						AUTHOR_WEBSITE: AUTHOR_WEBSITE.value(),
						AUTHOR_NAME: AUTHOR_NAME.value(),
					},
				});
				logger.info("Email sent", {
					to: participants[index].name,
					drawn: assignees[index].name,
					result,
				});
			} catch (error) {
				errors.push(error instanceof Error ? error.message : `${error}`);
				logger.error("Email failed", {
					to: participants[index].name,
					drawn: assignees[index].name,
					error,
				});
			}
		}

		if (errors.length > 0) {
			response.status(500).send({ errors });
		} else {
			response.send("Secret Santa draw complete");
		}
	},
);

const asStringForComparison = ({ name, email }: Participant): string => {
	return `${name}¶${email}`;
};

const hasDuplicates = (participants: readonly Participant[]): boolean => {
	return (
		new Set(participants.map(asStringForComparison)).size !==
		participants.length
	);
};
