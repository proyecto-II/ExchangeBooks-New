import { openai } from "../config/openai.js";

class RecomentationService {
  async getBooks(categories) {
    const complete = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: `
      Dame una recomendacion aleatorio de la siguiente lista segun la siguiente categorias ${categories} \n
      [
        {
            "_id": "647285c82ac97827d295d578",
            "title": "Titulo",
            "author": "nico",
            "description": "Descripción",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/9788403519107.jpg"
            ],
            "createdAt": "2023-05-27T22:35:52.126Z",
        },
        {
            "_id": "64825a570b63ee2a99373595",
            "title": "El Viento Conoce mi Nombre",
            "author": "Isabel Allende",
            "description": "Una conmovedora novela de violencia, solidaridad, amor y redención, que narra las historias entrecruzadas de dos niños unidos por el desarraigo",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/382bfaa1ec702efa1a79f0b47e19a086.jpeg"
            ],
            "createdAt": "2023-06-08T22:46:47.660Z",
        },
        {
            "_id": "6482624c0b63ee2a99373599",
            "title": "Harry Potter y la piedra filosofal",
            "author": "J.K Rowling",
            "description": "Instalado en casa de la horrible familia Dursley, en el número 4 de Privet Drive, donde duerme en una alacena bajo la escalera y a los once años nunca ha celebrado su cumpleaños, la magia es algo totalmente desconocido para Harry Potter",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/harry-potter.jpg"
            ],
            "createdAt": "2023-06-08T23:20:44.687Z",
        },
        {
            "_id": "6482671d0b63ee2a9937359b",
            "title": "Por que Meditar",
            "author": "Daniel Goleman",
            "description": "Todos experimentamos emociones negativas de vez en cuando. Pero en un mundo con tanto frenesí y presión como el nuestro, es fácil que estas mismas emociones se vuelvan destructivas",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/0d024d3eb5251a90247d1cef68bf7c10.jpeg"
            ],
            "createdAt": "2023-06-08T23:41:17.536Z",
        },
        {
            "_id": "648380157864044c3887981c",
            "title": "Test",
            "author": "test",
            "description": "test",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/9788403519107.jpg"
            ],
            "createdAt": "2023-06-09T19:40:05.154Z",
        },
        {
            "_id": "64ab3196b99b9113274ba0e0",
            "title": "Proyecto de innovacion",
            "author": "asdas",
            "description": "dasda",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/9788403519107.jpg"
            ],
            "createdAt": "2023-07-09T22:15:50.429Z",
        },
        {
            "_id": "64ac3be8f48ef14091472e3a",
            "title": "La maravilla",
            "author": "Prieta",
            "description": "En una era hace demasiados años",
            "type": "Libro",
            "images": [
                "https://exchangebooks.s3.us-east-2.amazonaws.com/books/1689009127590.jpg"
            ],
            "createdAt": "2023-07-10T17:12:08.554Z",
        }
    ]
      La repuesta debe solo el string con la id del libro`,
      temperature: 0.1,
      max_tokens: 2048,
    });

    return complete;
  }
}

export default RecomentationService;
