tableextension 50147 CustomerExt extends Customer
{
    fields
    {
        field(50000; "Customer Type"; Option)
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Replaced by new Enum Field Customer_Type';
            OptionMembers = " ",Bank,Microfinance,Sacco,Tenant;
            OptionCaption = ' ,Bank,Microfinance,Sacco,Tenant';
        }
        field(50001; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Employee No.");
                if Emp.FindFirst() then begin
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    Address := Emp.Address;
                    "Address 2" := Emp."Address 2";
                    City := Emp.City;
                    "Country/Region Code" := Emp."Country/Region Code";
                    "E-Mail" := Emp."E-Mail";
                    "Post Code" := Emp."Post Code";
                    "Mobile Phone No." := Emp."Mobile Phone No.";
                    "Phone No." := Emp."Mobile Phone No.";
                    "ID Number" := Emp."ID No.";
                    "Fax No." := Emp."Fax No.";
                    "Individual Pin Number" := Emp."PIN Number";
                end;
            end;
        }
        field(55041; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Bank: Record Banks;
            begin
                if Bank.get("Bank Code") then "Bank Code Name" := Bank.Name;
            end;
        }
        field(55042; "Bank Code Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(55043; "Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                if BankBranches.get("Bank Code", "Bank Branch Code") then "Bank Branch Name" := BankBranches."Branch Name";
            end;
        }
        field(55044; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(55045; "Bank Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(55046; PML; Boolean)
        {
        }
        field(55047; "CustomerType"; Enum CustomerType)
        {
            Caption = 'Customer Type';
        }
        field(55048; "Date of Incorporation"; date)
        {
            Caption = 'Date of Incorporation';
        }
        field(55049; "Created By"; Code[50])
        {
        }
        field(55050; "Date-Time Created"; DateTime)
        {
        }
        field(55051; "Shareholding Value"; Decimal)
        {
        }
        field(55052; "Payroll Loan No. Filter"; Code[50])
        {
            TableRelation = "Loan Application" where("Debtors Code" = field("No."));
            FieldClass = FlowFilter;
        }
        field(55053; "Loan Transaction Type Filter"; enum LoanTransactionTypes)
        {
            FieldClass = FlowFilter;
        }
        field(55054; "PML Abbreviation"; Code[10])
        {
        }
        field(55055; "Company Pin No."; Code[100])
        {
            Caption = 'Company Pin No.';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetFilter("No.", '<>%1', "No.");
                Customer.SetRange("Company Pin No.", "Company Pin No.");
                if Customer.FindFirst() then Error('Customer with same company pin number already exists');
            end;
        }
        field(55056; "Company Registration No."; Code[100])
        {
            Caption = 'Company Registration No.';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetFilter("No.", '<>%1', "No.");
                Customer.SetRange("Company Registration No.", "Company Registration No.");
                if Customer.FindFirst() then Error('Customer with same company registration number already exists');
            end;
        }
        field(55057; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetFilter("No.", '<>%1', "No.");
                Customer.SetRange("ID Number", "ID Number");
                if Customer.FindFirst() then Error('Customer with same ID number already exists');
            end;
        }
        field(55058; "Individual Pin Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetFilter("No.", '<>%1', "No.");
                Customer.SetRange("Individual Pin Number", "Individual Pin Number");
                if Customer.FindFirst() then Error('Customer with same pin number already exists');
            end;
        }
        field(55059; "Imprest Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(55060; "Petty Cash Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(55061; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55062; "Cust. Trans. Type Filter"; enum "Customer Transaction Types")
        {
            FieldClass = FlowFilter;
        }
        field(55063; "Balance Due(LCY2)"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."), "Initial Entry Due Date" = FIELD(UPPERLIMIT("Date Filter")), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter"), "Customer Transaction Type" = field("Cust. Trans. Type Filter")));
            Caption = 'Balance Due (LCY2)';
            Editable = false;
        }
        field(55064; "Balance (LCY)2"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter"), "Customer Transaction Type" = field("Cust. Trans. Type Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
        }
    }
}
