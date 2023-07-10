import "dotenv/config";

export const OPENAI_API_KEY = process.env.OPENAI_API_KEY || "";
export const LOCAL_DATA = [
  {
    title: "Libro 1",
    description: "Descripcion del libro 1",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 1",
  },
  {
    title: "Libro 2",
    description: "Descripcion del libro 2",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 2",
  },
  {
    title: "Libro 3",
    description: "Descripcion del libro 3",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 3",
  },
  {
    title: "Libro 4",
    description: "Descripcion del libro 4",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 4",
  },
  {
    title: "Libro 5",
    description: "Descripcion del libro 5",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 5",
  },
  {
    title: "Libro 6",
    description: "Descripcion del libro 6",
    image:
      "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",
    author: "Autor 6",
  },
];
export const BOOK_SERVICE_URL = process.env.BOOK_SERVICE_URL || "";
