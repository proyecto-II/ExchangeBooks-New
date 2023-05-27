import multer from "multer";
import multerS3 from "multer-s3";
import { S3Client } from "@aws-sdk/client-s3";
import { AWS_SECRET_ACCESS_KEY, AWS_SECRET_KEY_ID } from "./constants.js";

const s3Config = new S3Client({
  credentials: {
    secretAccessKey: AWS_SECRET_ACCESS_KEY || "",
    accessKeyId: AWS_SECRET_KEY_ID || "",
  },
  region: "us-east-2",
});

export const uplodImage = multer({
  storage: multerS3({
    s3: s3Config,
    bucket: "exchangebooks",
    acl: "private",
    metadata: (req, file, cb) => {
      cb(null, { fieldName: file.fieldname });
    },
    key: (req, file, cb) => {
      const extension = file.originalname.split(".")[1];
      const folder = req.query?.folder || "images";
      cb(null, `${folder}/${Date.now().toString()}.${extension}`);
    },
  }),
});
