import { openai } from "../../../exchangebooks_book/src/config/openai";

class RecomentationService {
  constructor() {}

  async getBooks() {
    const complete = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: `
      Genera 1 recomendacion de libro, comic o manga a partir de las siguientes categorias; ${categories} \n
      La repuesta solo debe ser una lista de objectos con la key en comillas dobles, con los siguientes campos; title, description y author,  
      `,
      temperature: 0.6,
      max_tokens: 2048,
    });

    return complete;
  }
}

export default RecomentationService;
