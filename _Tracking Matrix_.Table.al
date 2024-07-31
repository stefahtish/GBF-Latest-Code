table 50685 "Tracking Matrix"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; userid; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Current Status"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Previous Status"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Overal Project Status"; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Schedule"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Project Risk"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionCaption = '';
            OptionMembers = "";
        }
        field(11; "AccomplishmentsSincelast"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accomplishment since Lst Report';
        }
        field(12; "UpcomingSteps"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Key Issues"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Upcoming MileStones"; Text[50])
        {
        }
        field(17; "Completion Dates"; Date)
        {
            DataClassification = ToBeClassified;
        //List of Upcoming Tasks
        }
    }
    keys
    {
        key(Key1; MyField)
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
