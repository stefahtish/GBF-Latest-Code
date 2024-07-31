page 50985 "Sample Disposal Card"
{
    Caption = 'Sample Disposal Card';
    PageType = Card;
    SourceTable = "Sample Disposal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sample Reception No."; Rec."Sample Reception No.")
                {
                    ApplicationArea = All;
                }
                field("Disposal Date"; Rec."Disposal Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Disposal Time"; Rec."Disposal Time")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part("Sample Disposal Lines"; "Sample Disposal Lines")
            {
                SubPageLink = "No." = field("No.");
                //visible = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = not Rec.Disposed;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    LabMgmt: Codeunit "Laboratory Management";
                begin
                    LabMgmt.SampleDisposal(Rec);
                    CurrPage.Close();
                end;
            }
        }
    }
}
