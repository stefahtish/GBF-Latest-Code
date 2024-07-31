page 51125 "Perfomance Contract Target"
{
    Caption = 'Perfomance Contract Target Card';
    PageType = Card;
    SourceTable = "Perfomance Targets";
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

                    trigger Onvalidate()
                    begin
                        CurrPage.Update();
                        Rec.Validate("Criteria Code");
                    end;
                }
                field("Criteria Description"; Rec."Criteria Description")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Pefomance Indicator Code"; Rec."Pefomance Indicator Code")
                {
                    Caption = 'SubCriteria Code';
                }
                field("Indicator Description"; Rec."Indicator Description")
                {
                    Caption = 'SubCriteria description';
                }
                field(KRA; Rec.KRA)
                {
                    ApplicationArea = All;
                }
                field("KRA Description"; Rec."KRA Description")
                {
                    ApplicationArea = All;
                    editable = false;
                    Enabled = false;
                }
                field("Strategic Issue"; Rec."Strategic Issue")
                {
                    ApplicationArea = All;
                }
                field("Strategic Issue Description"; Rec."Strategic Issue Description")
                {
                    ApplicationArea = All;
                    editable = false;
                    Enabled = false;
                }
                field("Strategic Objective Code"; Rec."Strategic Objective Code")
                {
                    ApplicationArea = All;
                }
                field("Strategic Obj. Description"; Rec."Strategic Obj. Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                }
                field("Strategy Code"; Rec."Strategy Code")
                {
                    ApplicationArea = All;
                }
                field("Strategy Description"; Rec."Strategy Description")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                // field(Unit; Rec.Unit)
                // {
                //     ApplicationArea = All;
                // }
                // field(Weight; Rec.Weight)
                // {
                //     ApplicationArea = All;
                // }
                field(TimeFrame; Rec.TimeFrame)
                {
                    ApplicationArea = All;
                }
                // field("Annual  Target"; Rec."Annual  Target")
                // {
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                // field("Q1 Target"; Rec."Q1 Target")
                // {
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                // field("Q2 Target"; Rec."Q2 Target")
                // {
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                // field("Q3 Target"; Rec."Q3 Target")
                // {
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                // field("Q4 Target"; Rec."Q4 Target")
                // {
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part(Lines; "Perfomance Target Lines")
            {
                visible = false;
                SubPageLink = "Document No." = field("Document No."); //, TimeFrame = field(TimeFrame)
                UpdatePropagation = Both;
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
                    currpage.close;
                end;
            }
        }
    }
}
