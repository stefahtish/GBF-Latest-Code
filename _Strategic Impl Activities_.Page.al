page 50615 "Strategic Impl Activities"
{
    PageType = ListPart;
    Caption = 'Strategic Activities';
    SourceTable = "Strategic Imp Activities";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Activities; Rec.Activities)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(KPI; Rec.KPI)
                {
                    Caption = 'Key Perfomance Indicators';
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Measure; Rec.Measure)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Priority; Rec.Priority)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
