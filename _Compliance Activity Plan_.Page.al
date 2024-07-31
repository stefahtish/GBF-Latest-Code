page 50945 "Compliance Activity Plan"
{
    PageType = Card;
    SourceTable = "Compliance Activity Plan";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Description of activity"; Rec."Description of activity")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Subcounty; Rec.Subcounty)
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                    Rec.Modify();
                    exit;
                end;
            }
            action(Reopen)
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Submitted := false;
                    Rec.Modify();
                    exit;
                end;
            }
        }
    }
}
