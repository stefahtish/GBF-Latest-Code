table 50161 "Tender Committee Appointment"
{
    Caption = 'Tender Committee Appointment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tender/Quotation No"; Code[20])
        {
            Caption = 'Tender/Quotation No';
            TableRelation = "Procurement Request";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF TenderRec.GET("Tender/Quotation No")THEN BEGIN
                    Title:=TenderRec.Title;
                END;
            end;
        }
        field(2; "Committee ID"; Code[20])
        {
            Caption = 'Committee ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Committee Name"; Text[50])
        {
            Caption = 'Committee Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(6; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(7; "Appointment No"; Code[20])
        {
            Caption = 'Appointment No';
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment";
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Tender/Quotation No")
        {
            Clustered = true;
        }
    }
    var TenderRec: Record "Procurement Request";
}
