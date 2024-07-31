table 50344 "Appraisal Recommendations"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Recommendation Type"; Option)
        {
            OptionMembers = " ", "Performance Reward", "Promotional Potential", "Recognition";
            OptionCaption = ' ,Performance Reward,Promotional Potential,Recognition';
        }
        field(4; "Performance Reward"; Option)
        {
            OptionMembers = " ", "Merit Increment", "Annual Increment", "Increment Deffered Until";
            OptionCaption = ' ,Merit Increment,Annual Increment,Increment Deffered Until';
        }
        field(5; "Increment Until Date"; Date)
        {
        }
        field(6; "Ready for Promotion"; Boolean)
        {
        }
        field(7; "Has Potential for Promotion"; Boolean)
        {
        }
        field(8; "Capable of Performing present"; Boolean)
        {
        }
        field(9; "Unlikely to Go Further"; Boolean)
        {
        }
        field(10; "Unsuitable for Promotion"; Boolean)
        {
        }
        field(11; "Recognition Reason"; Text[1000])
        {
        }
        field(12; "Recognition By"; Option)
        {
            OptionMembers = " ", "Merit Award", "Letter of Recommendation", "Other";
            OptionCaption = ' ,Merit Award,Letter of Recommendation,Other';
        }
        field(13; "Other Recognition"; Text[100])
        {
        }
        field(14; Person; Option)
        {
            OptionMembers = " ", Appraiser, Appraisee, "Second Appraiser", "HOD";
            OptionCaption = ' ,Appraiser,Appraisee,Second Appraiser,HOD';
        }
    }
    keys
    {
        key(Key1; "Appraisal No.", "Line No.")
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
