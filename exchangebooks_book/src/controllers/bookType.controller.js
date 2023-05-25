import BookTypeService from "../services/bookType.service.js";

const bookTypeService = new BookTypeService();

export async function getAllBookTypes(req, res) {
  try {
    const types = await bookTypeService.getAll();
    return res.status(200).send(types);
  } catch (err) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
}

export async function createBookType(req, res) {
  try {
    const type = await bookTypeService.create(req.body);
    return res.status(201).send(type);
  } catch (err) {
    return res.status(500).json({
      message: "Something went wrong",
      error: err,
    });
  }
}
