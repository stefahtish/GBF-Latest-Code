page 50545 "Appraisal Values"
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
                field(Values; Rec.Description)
                {
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
