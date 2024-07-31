tableextension 50121 "Qualification Table Ext" extends Qualification
{
    fields
    {
        field(50000; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(50001; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
        }
        field(50002; "Education Level";enum "Education Level")
        {
            DataClassification = ToBeClassified;
        }
    }
}
