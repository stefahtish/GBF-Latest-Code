page 50548 "Appraisal Research"
{
    PageType = ListPart;
    SourceTable = "Appraisal Competences";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                }
                field("Value/Core Competence"; Rec."Core Value/Competence")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Indicator';
                }
                field(Score; Rec.Score)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }
    actions
    {
    }
}
