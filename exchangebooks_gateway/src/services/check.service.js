import axios from "axios";

class CheckService {
  constructor() {}

  async check(services) {
    const promises = services.map((service) =>
      axios
        .get(service.url)
        .then((response) => {
          if (response.status === 200) {
            return { ...service, status: 200, message: "[🔋]Running" };
          } else {
            return { ...service, status: 400, message: "[⚠]Error" };
          }
        })
        .catch((_) => {
          return { ...service, status: 400, message: "[⚠]Error" };
        })
    );

    const results = await Promise.all(promises);

    return results;
  }
}

export default CheckService;
