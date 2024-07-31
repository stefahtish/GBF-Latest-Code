page 50503 "Qualified Interviewee Card"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Positions; Rec.Positions)
                {
                }
                field("Employment Done"; Rec."Employment Done")
                {
                }
                field("Employment Date"; Rec."Employment Date")
                {
                }
            }
            part(Control6; "Qualified Interviewee Listpart")
            {
                SubPageLink = "No." = FIELD("No."), Qualified = CONST(true);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Employ)
            {
                Image = User;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to employ the selected candidates?', true) = false then begin
                        exit
                    end
                    else begin
                        Rec."Employment Done" := true;
                        Rec."Employment Date" := Today;
                    end;
                end;
            }
        }
    }
}
