import { openai } from "../config/openai.js";

class RecomentationService {
  constructor() {}

  async getBooks(categories) {
    const complete = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: `
      Genera 6 recomendaciones de libros, comic o mangas a partir de las siguientes categorias; ${categories} \n
      La repuesta solo debe ser una lista de objetos con la key en comillas dobles, con los siguientes campos; title, description, author e image,  
      `,
      temperature: 0.6,
      max_tokens: 2048,
    });

    return complete;
  }
}

export default RecomentationService;
