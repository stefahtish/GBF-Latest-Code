page 51058 "Research Objectives"
{
    PageType = ListPart;
    SourceTable = "ResearchSurvey Workplan Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Objectives';
                    ApplicationArea = Basic, Suite;

                    trigger Onvalidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field(Outcome; Rec.Outcome)
                {
                    Caption = 'Output';
                    ApplicationArea = Basic, Suite;
                    visible = Submitted;
                }
                field("Quantification of outcome"; Rec."Quantification of outcome")
                {
                    Caption = 'Rating/Remarks';
                    ApplicationArea = Basic, Suite;
                    visible = Submitted;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        Submitted: Boolean;

    procedure SetControlAppearance()
    var
        ResearchWp: Record "Research and survey Workplan";
    begin
        ResearchWp.SetRange(Code, Rec.Code);
        if ResearchWp.FindFirst() then begin
            if ResearchWp.Submitted = true then
                Submitted := true
            else
                Submitted := false;
        end;
    end;
}
