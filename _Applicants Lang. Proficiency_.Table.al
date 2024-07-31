table 50340 "Applicants Lang. Proficiency"
{
    Caption = 'Applicant Languages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Language; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Not Languages.Get(Language)then begin
                    Languages.Init();
                    Languages.code:=Language;
                    Languages.Name:=Language;
                    Languages.Insert();
                end;
            end;
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4; "Read"; Option)
        {
            OptionMembers = " ", Fair, Good, Fluent, Native;
            OptionCaption = ' ,Fair,Good,Fluent,Native';
        }
        field(5; "Write"; Option)
        {
            OptionMembers = " ", Fair, Good, Fluent, Native;
            OptionCaption = ' ,Fair,Good,Fluent,Native';
        }
        field(6; "Speak"; Option)
        {
            OptionMembers = " ", Fair, Good, Fluent, Native;
            OptionCaption = ' ,Fair,Good,Fluent,Native';
        }
    }
    keys
    {
        key(PK; "No.", "Line No", Language)
        {
            Clustered = true;
        }
    }
    var Languages: Record Language;
}
