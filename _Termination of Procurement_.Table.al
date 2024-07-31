table 50197 "Termination of Procurement"
{
    Caption = 'Termination of Procurement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender, EOI, "FA Disposal Quote";
        }
        field(3; "Ref No"; Code[100])
        {
            Caption = 'Ref No';
            DataClassification = ToBeClassified;
        }
        field(4; "Tender/Quotation No"; Code[20])
        {
            Caption = 'Tender/Quotation No';
            DataClassification = ToBeClassified;
        }
        field(5; Nature;Enum SupplierTypes)
        {
            Caption = 'Nature';
            DataClassification = ToBeClassified;
        }
        field(6; "Prepared By"; Code[50])
        {
            Caption = 'Prepared By';
            DataClassification = ToBeClassified;
        }
        field(7; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Termination"; Date)
        {
            Caption = 'Date of Termination';
            DataClassification = ToBeClassified;
        }
        field(9; "Termination Code"; Code[20])
        {
            Caption = 'Termination Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Reason for Termination"; Text[2048])
        {
            Caption = 'Reason for Termination';
            DataClassification = ToBeClassified;
        }
        field(11; Status;Enum "Approval Status-custom")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(12; "Stage as at termination"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Archived,Opening,Pending Approval,Approved,Rejected,Terminated';
            OptionMembers = New, Archived, Opening, "Pending Approval", Approved, Rejected, Terminated;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
