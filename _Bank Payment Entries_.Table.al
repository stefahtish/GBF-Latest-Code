table 50723 "Bank Payment Entries"
{
    Caption = 'Bank Payment Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."Bill Number Nos");
            end;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "CustomerRefNumber"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Bank Reference"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Bill Amount"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Payment Mode"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(7; "Phone Number"; Code[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Debit Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Debit CustName"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Bill Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CashMgt.Get;
        CashMgt.TestField("Bill Number Nos");
        if "No." = '' then NoSeriesMgt.InitSeries(CashMgt."Bill Number Nos", xRec."No. Series", 0D, "No.", "No. Series");
        "Created Date":=Today;
        "Created By":=UserId;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    CashMgt: Record "Cash Management Setups";
}
