page 51024 "Monthly Form of Return"
{
    Caption = 'Monthly Form of Return';
    PageType = Card;
    SourceTable = "Monthly Form of Return";
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
                field(ApplicantNo; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Base Date"; Rec."Base Date")
                {
                    Caption = 'Return Date';
                    ApplicationArea = All;
                }
                // field("License No."; "License No.")
                // {
                //     Caption = 'Regulatory Permit No.';
                //     ApplicationArea = All;
                // }
                // field("License Type"; Rec."License Type")
                // {
                //     Caption = 'Regulatory Permit';
                //     ApplicationArea = All;
                //     Enabled = false;
                // }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Returning Officer's Name"; Rec."Returning Officer's Name")
                {
                    ApplicationArea = All;
                }
                field("Returning Officer's Designation"; Rec."Returning Officer Designation")
                {
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    Caption = 'Application Date';
                }
                field("Date of Last Return"; Rec."Date of Last Return")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Submitted; Rec.Submitted)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            part(Permits; "Montly return Permits")
            {
                SubPageLink = "No." = field("No."), "Applicant No" = field("Applicant No.");
                UpdatePropagation = Both;
                visible = false;
            }
            part(Intak; "Monthly Return Intake")
            {
                SubPageLink = "Application No" = field("No.");
                UpdatePropagation = Both;
            }
            part(Product; "Monthly Return Product")
            {
                SubPageLink = ApplicationNo = field("No.");
            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = All;
            }
            label(DECLARATION)
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            label("I dclare that the above information is correct")
            {
                // Style = Strong;
                // StyleExpr = TRUE;
            }
            field(Name; Rec."Applicant Name")
            {
            }
            field(Address; Rec.Address)
            {
            }
            field("Email Address"; Rec."Email Address")
            {
            }
            field("Telephone Number"; Rec."Telephone Number")
            {
            }
            field(Signature; Rec.Signature)
            {
            }
            field(Acknowledge; Rec.Acknowledge)
            {
            }
            field(Stamp; Rec.Stamp)
            {
            }
            field(Date; Rec.Date)
            {
            }
            label("(if the signature is on behalf of the limited company or estate, this must be stated)")
            {
                // Style = Strong;
                // StyleExpr = TRUE;
            }
            label("FOR OFFICIAL USE ONLY")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
            label("Consumer safety levy charged at 40 cents per KilogramOR 1% of the cost of processed milk (whichever is higher)")
            {
                // Style = Strong;
                // StyleExpr = TRUE;
            }
            field("Levy Amount"; Rec."Levy Amount")
            {
                caption = 'Consumer safety levy';
                ApplicationArea = All;
            }
            field("Levy Penalty"; Rec."Levy Penalty")
            {
                caption = 'Penalty';
                ApplicationArea = All;
            }
            field("Total Amount"; Rec."Total Amount")
            {
            }
            field("Amount in words"; Rec."Amount in words")
            {
            }
            field("Invoice No."; Rec."Invoice No.")
            {
                Caption = 'Debit Note No';
            }
            field("Receipt No."; Rec."Receipt No.")
            {
            }
            field("Officer's Name"; Rec."Officer's Name")
            {
            }
            field("Officer's Signature"; Rec."Officer's Signature")
            {
            }
            field("Officer signature Date"; Rec."Officer signature Date")
            {
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
                var
                    ComplianceMgmt: codeunit "Compliance Management";
                begin
                    ComplianceMgmt.CalculatePayments(Rec."No.");
                    Rec.Submitted := true;
                    currpage.close;
                end;
            }
            action("Calculate Levy")
            {
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ComplianceMgmt: codeunit "Compliance Management";
                begin
                    ComplianceMgmt.CalculatePayments(Rec."No.");
                    Rec.Submitted := true;
                    currpage.close;
                end;
            }
            action(Logs)
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "Applicant penalty Logs";
                RunPageLink = "Document No." = field("No.");
            }
            action("Initiate Payment")
            {
                Image = SendMail;
                Promoted = true;
                Visible = Rec.Submitted;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Paymgmt: codeunit "Payments Management";
                begin
                    Paymgmt.InvoiceMonthlyFormOfReturn(Rec."No.");
                    currpage.close;
                end;
            }
            action("Receipt Payment")
            {
                Image = SendMail;
                Promoted = true;
                Visible = Rec.Submitted;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Mpesa: codeunit "MPESA Integration";
                begin
                    Mpesa.PostPayments(Rec."No.");
                    currpage.close;
                end;
            }
            action("Monthly Form of Return")
            {
                Image = SendMail;
                Promoted = true;
                Visible = Rec.Submitted;
                PromotedCategory = Report;
                PromotedIsBig = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    MonthlyReturn.SetTableView(Rec);
                    MonthlyReturn.Run();
                end;
            }
        }
    }
    var
        MonthlyReturn: Report "Monthly Form of Return";
}
