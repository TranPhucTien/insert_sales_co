import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import {
    insertCustomer,
    insertTransaction,
    insertProduct,
    insertInvoice,
    insertLine,
} from './components/index.js';
import route from './routes/index.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5001;

// apply middleware
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.status(200).json({ success: true });
});

// Routes init
route(app);

app.listen(PORT, () => {
    console.log(`⚡️[server]: Server is running at ${PORT}`);
});

// ---------------- INSERT INTO ACCT_TRANSACTION -----------------
// Default value for numberOfRecords of ACCT_TRANSACTION: 1000
// insertTransaction({ numberOfRecords: 10000 });

// ---------------- INSERT INTO CUSTOMER -----------------
// Default value for numberOfRecords of CUSTOMER: 10
// insertCustomer({ numbersOfRecords: 10 });

// ---------------- INSERT INTO PRODUCT -----------------
// Vendor code must be in the vendor table. Insert VENDOR in ./sql/insertTables.sql
// Default value for name of PRODUCT: laptop
// Default value for vendorCode of PRODUCT: 1
insertProduct({ name: 'kindle', vendorCode: 2 });

// ---------------- INSERT INTO INVOICE -----------------
// Must have value of CUSTOMER table
// Default value for numberOfRecords of INVOICE: 1000
// insertInvoice({ numberOfRecords: 10000 });

// ---------------- INSERT INTO LINE -----------------
// Must have value of PRODUCT table and INVOICE table
// Default value for numberOfRecords of LINE: 1000
// insertLine({ numberOfRecodes: 10000 });
