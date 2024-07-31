page 51480 "Interview Committee Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Interview Committe";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    Editable = Rec.Processed = false;
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("General Notes"; Rec."General Notes")
                {
                    MultiLine = true;
                    Editable = Rec.Processed = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field(Processed; Rec.Processed)
                {
                }
            }
            part("Committe Members"; "Interview Panel Members")
            {
                Editable = Rec.Processed = false;
                SubPageLink = "Panel Member Code"=field("No.");
            }
            part("Setup Entries"; "Interview Setup Entries")
            {
                Editable = Rec.Processed = false;
                SubPageLink = "No."=field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Link Committee to Interview")
            {
                ApplicationArea = All;
                //Promoted = true;
                //PromotedCategory = Process;
                //PromotedIsBig = true;
                Image = Link;
                Visible = Rec.Processed = false;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to link this commit to an interview?', false)then exit
                    else
                    begin
                        ProMgt.CreateTestParameterEntries(Rec);
                        ProMgt.CreateInterviewEntries(Rec);
                        Rec.Processed:=true;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
    var ProMgt: Codeunit ProjectManagement;
}
