import axios from "axios";

import { API_URL } from "../constants/";

const commonApi = {
    getAllArticle: () =>
        axios.get(`${API_URL}/articles`, {
            headers: {
                Authorization: "Bearer " + localStorage.getItem("token"),
            },
        }),

    getArticleById: (id) =>
        axios.get(`${API_URL}/articles?id=` + id, {
            headers: {
                Authorization: "Bearer " + localStorage.getItem("token"),
            },
        }),

    addArticle: (name, contract_amount, is_house, ended, budgets) =>
        axios.post(
            `${API_URL}/articles`,
            {
                name,
                contract_amount,
                is_house,
                ended,
                budgets,
            },
            {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("token"),
                },
            }
        ),

    editArticle: (article_id, name, contract_amount, is_house, ended) =>
        axios.put(
            `${API_URL}/articles/${article_id}`,
            {
                name,
                is_house,
                ended,
                contract_amount,
            },
            {
                headers: {
                    Authorization: "Bearer " + localStorage.getItem("token"),
                },
            }
        ),
};

export default commonApi;
