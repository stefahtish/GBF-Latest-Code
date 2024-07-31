page 51127 "Perfomance Contract Actual"
{
    Caption = 'Perfomance Contract Actual Card';
    PageType = Card;
    SourceTable = "Perfomance Contract Actuals";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
                field("Criteria Code"; Rec."Criteria Code")
                {
                    ApplicationArea = All;
                }
                field("Criteria Description"; Rec."Criteria Description")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
                field("SubCriteria Code"; Rec."SubCriteria Code")
                {
                    ApplicationArea = All;
                }
                field("SubCriteria Description"; Rec."SubCriteria Description")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(TimeFrame; Rec.TimeFrame)
                {
                    ApplicationArea = All;
                }
                field(Quarter; Rec.Quarter)
                {
                    ApplicationArea = All;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
            }
            part(Lines; "Perfomance Actuals Lines")
            {
                SubPageLink = "Document No." = field("Document No."), TimeFrame = field(TimeFrame);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Submit)
            {
                Visible = not Rec.closed;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.closed := true;
                    commit;
                    Message('Successfully submitted');
                    CurrPage.Close();
                end;
            }
        }
    }
}
