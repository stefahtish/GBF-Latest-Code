page 50602 "Company Job Education"
{
    Caption = 'Company Job Education';
    PageType = ListPart;
    SourceTable = "Company Job Education";
    AutoSplitKey = true;
    SourceTableView = where("Education Level" = filter(<> Professional));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field of Education"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
