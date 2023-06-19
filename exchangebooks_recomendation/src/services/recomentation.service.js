import { openai } from "../config/openai.js";

class RecomentationService {
  constructor() {}

  async getBooks(categories) {
    const complete = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: `
      Genera 1 recomendacion de libro, comic o mangas a partir de las siguientes categorias; ${categories} \n
      La repuesta solo debe ser una lista de objetos con la key en comillas dobles, con los siguientes campos; title, author y agrega image con esta url "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg",  
      `,
      temperature: 0.6,
      max_tokens: 2048,
    });

    return complete;
  }
}

export default RecomentationService;
