import salecoRouter from './Saleco.js';

function route(app) {
    app.use('/api/saleco', salecoRouter);
}

export default route;
