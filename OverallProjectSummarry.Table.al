table 50688 OverallProjectSummarry
{
    DataClassification = ToBeClassified;
    Caption = 'Overall Project Status';

    fields
    {
        field(1; "Project No."; Code[50])
        {
        }
        field(124; "Current Status"; integer)
        {
            DataClassification = ToBeClassified;
        // OptionCaption = 'Work in Progress,Complete,Overdue';
        // OptionMembers = "Work in Progress",Complete,Overdue;
        }
        field(125; "Previous Status"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(147; "Overal Status Summary"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Overall Status Summary';
        }
        field(148; "Line"; Integer)
        {
            DataClassification = ToBeClassified;
            //Caption = 'Overall Status Summary';
            AutoIncrement = true;
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
