table 50166 "Finance Management Cue"
{
    Caption = 'Finance and Treasury Management Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; Vendors; Integer)
        {
            Caption = 'Vendors';
            FieldClass = FlowField;
            CalcFormula = count(Vendor);
        }
        field(3; Customers; Integer)
        {
            Caption = 'Customers';
            FieldClass = FlowField;
            CalcFormula = count(Customer);
        }
        field(4; "Payment Voucher"; Integer)
        {
            Caption = 'Payment Voucher';
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Payment Voucher"), Posted=const(false)));
        }
        field(5; "Posted Payment Voucher"; Integer)
        {
            Caption = 'Posted Payment Voucher';
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Payment Voucher"), Posted=const(true)));
        }
        field(6; Receipts; Integer)
        {
            Caption = 'Receipts';
            FieldClass = FlowField;
            CalcFormula = count(Payments WHERE(Posted=CONST(false), "Payment Type"=CONST(Receipt)));
        }
        field(7; "Posted Receipts"; Integer)
        {
            Caption = 'Posted Receipts';
            FieldClass = FlowField;
            CalcFormula = count(Payments WHERE(Posted=CONST(true), "Payment Type"=CONST(Receipt)));
        }
        field(8; "Petty cash"; Integer)
        {
            Caption = 'Petty cash';
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash"), Status=CONST(Released), Posted=CONST(false)));
        }
        field(13; "Posted petty cash"; Integer)
        {
            Caption = 'Posted petty cash';
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash"), Status=CONST(Released), Posted=CONST(true)));
        }
        field(14; "Sales Invoices"; Integer)
        {
            Caption = 'Sales Invoices';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type"=CONST(Invoice)));
        }
        field(15; "Posted Sales Invoices"; Integer)
        {
            Caption = 'Posted Sales Invoices';
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header");
        }
        field(24; "Requests to Approve"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Approver ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(25; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Sender ID"=FIELD("User ID Filter"), Status=FILTER(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(26; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(27; "Imprests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST(Imprest), Status=CONST(Open)));
        }
        field(28; "Posted imprests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST(Imprest), Status=CONST(Released), Posted=CONST(true)));
        }
        field(29; "Petty cash surrender"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash Surrender"), Posted=CONST(false)));
        }
        field(30; "Posted petty cash surrenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash Surrender"), Status=CONST(Released), Posted=CONST(true)));
        }
        field(31; "Imprest Surrender"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Imprest Surrender"), Posted=CONST(false)));
        }
        field(32; "Posted Imprest Surrender"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Imprest Surrender"), Status=CONST(Released), Posted=CONST(true)));
        }
        field(36; "Pending Petty Cash"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash"), Status=CONST("Pending Approval")));
        }
        field(37; "Pending Petty Cash Surrender"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Petty Cash Surrender"), Status=CONST("Pending Approval")));
        }
        field(38; "Pending Imprests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST(Imprest), Status=CONST("Pending Approval")));
        }
        field(39; "Pending Imprest Surrenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Imprest Surrender"), Status=CONST("Pending Approval")));
        }
        field(40; "Pending Payment Vouchers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Payments where("Payment Type"=CONST("Payment Voucher"), Status=CONST("Pending Approval")));
        }
        field(41; "Fixed Assets"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Asset");
        }
        field(42; "Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Bank Account");
        }
        field(43; "Bank Account Balances"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)");
        }
        field(44; "Purchase Invoices"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST(Invoice)));
        }
        field(45; "Posted Purchase Invoices"; Integer)
        {
            Caption = 'Posted Sales Invoices';
            FieldClass = FlowField;
            CalcFormula = count("Purch. Inv. Header");
        }
        field(46; "Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=CONST(Order)));
        }
        field(47; "Inventory"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Item);
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
