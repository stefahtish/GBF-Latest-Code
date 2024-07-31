table 50640 "License Approval Comments"
{
    Caption = 'License Approval Comments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No"; integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(3; "Comment"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Approval, Rejection;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Station Manager", "Head Office", HOD;
        }
        field(6; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Approver ID"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No", "Entry No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Appr: Record "License Approval Comments";
    begin
        Appr.Reset();
        Appr.SetRange("Document No", "Document No");
        if Appr.FindLast()then "Entry No":=Appr."Entry No" + 1
        else
            "Entry No":=1;
    end;
}
