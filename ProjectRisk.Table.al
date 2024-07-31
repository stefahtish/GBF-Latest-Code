table 50691 ProjectRisk
{
    DataClassification = ToBeClassified;
    Caption = 'Project Risk';

    fields
    {
        field(1; "Project No."; Code[50])
        {
        }
        field(124; "Current Status"; integer)
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        }
        field(125; "Previous Status"; integer)
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        }
        field(147; "Project Risks"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Risks';
        }
        field(148; "Line"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Overall Status Summary';
            AutoIncrement = true;
        }
        field(126; "Current Status 1"; Option)
        {
            Caption = 'Current Status';
            OptionMembers = "", Low, Medium, High;
        }
        field(127; "Previous Status 1"; Option)
        {
            Caption = 'Previous Status';
            DataClassification = ToBeClassified;
            OptionMembers = "", Low, Medium, High;
        }
    }
    keys
    {
        key(Key1; "Project No.", line)
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
