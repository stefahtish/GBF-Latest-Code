page 50895 "Audit Setup"
{
    Caption = 'Risk Setup';
    PageType = Card;
    SourceTable = "Audit Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Audit Management")
            {
                Visible = true;

                field("Audit Nos."; Rec."Audit Nos.")
                {
                }
                field("Audit Notification Nos."; Rec."Audit Notification Nos.")
                {
                }
                field("Audit Workplan Nos."; Rec."Audit Workplan Nos.")
                {
                }
                field("Audit Record Requisition Nos."; Rec."Audit Record Requisition Nos.")
                {
                }
                field("Audit Plan Nos."; Rec."Audit Plan Nos.")
                {
                }
                field("Work Paper Nos."; Rec."Work Paper Nos.")
                {
                }
                field("Audit Report Nos."; Rec."Audit Report Nos.")
                {
                }
                field("Inspection Report Nos."; Rec."Inspection Report Nos.")
                {
                    Caption = 'Special Inspection Nos.';
                }
                field("Audit Program Nos."; Rec."Audit Program Nos.")
                {
                }
                field("Strategic Audit Plan Nos."; Rec."Strategic Audit Plan Nos.")
                {
                }
                field("Quarterly Audit Plan Nos."; Rec."Quarterly Audit Plan Nos.")
                {
                }
                field("Project Nos."; Rec."Project Nos.")
                {
                }
            }
            group("Risk Management")
            {
                Caption = 'Risk';

                label(RiskGeneral)
                {
                    Caption = 'General';
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Risk Register Nos"; Rec."Risk Register Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Survey Threshold"; Rec."Risk Survey Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Organization Threshold"; Rec."Organization Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Threshold"; Rec."Department Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Project Threshold"; Rec."Project Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Officer Job ID"; Rec."Risk Officer Job ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(RiskNumbering)
                {
                    Caption = 'Numbering';
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Risk Nos."; Rec."Risk Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Reporting Nos."; Rec."Risk Reporting Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Survey Nos."; Rec."Risk Survey Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("User Incidences")
            {
                Caption = 'Incident';

                field("Incident Reporting Nos."; Rec."Incident Reporting Nos.")
                {
                    Caption = 'Incident Nos.';
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Email"; Rec."Risk Email")
                {
                    Caption = 'Incident E-Mail';
                    ApplicationArea = Basic, Suite;
                }
                field("Attachment Path"; Rec."Attachment Path")
                {
                    Caption = 'Attachment Path';
                    ApplicationArea = Basic, Suite;
                }
                group(Escalation)
                {
                    field("Escalation Due Date"; Rec."Escalation Due Date")
                    {
                        ToolTip = 'Number of days  from booking date before escalating incidences';
                    }
                    field("Escalation Email"; Rec."Escalation Email")
                    {
                        ToolTip = 'Email to receive escalation mail';
                    }
                    field("Escalation CC"; Rec."Escalation CC")
                    {
                        ToolTip = 'Other Email to receive escalation mail';
                    }
                }
            }
            group(Compliance)
            {
                Caption = 'Compliance';

                field("Compliance Nos."; Rec."Compliance Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
