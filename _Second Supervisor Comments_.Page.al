page 50552 "Second Supervisor Comments"
{
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    Visible = false;
                }
                field("Appraisal Report Comment"; Rec."Appraisal Report Comment")
                {
                }
                field("Performance Reward Comments"; Rec."Performance Reward Comments")
                {
                }
                field("Merit Increment"; Rec."Merit Increment")
                {
                }
                field("Annual Increment"; Rec."Annual Increment")
                {
                }
                field("Performance Reward Decision"; Rec."Performance Reward Decision")
                {
                    Caption = 'Sanctions';
                }
                field("Promotional Potential"; Rec."Promotional Potential")
                {
                }
                field(Recognition; Rec.Recognition)
                {
                }
            }
        }
    }
    actions
    {
    }
}
