page 51504 "Payment Listing"
{
    CardPageID = "GBF Payment Voucher";
    Editable = false;
    PageType = List;
    SourceTable = "GBF Payments";
    SourceTableView = WHERE(Posted=CONST(false));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field(No; Rec.No)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    /*IF Status<>Status::Open THEN
                        ERROR('You cannot change this document at this stage');*/
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN ERROR('You cannot change this document at this stage');
                    end;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN ERROR('You cannot change this document at this stage');
                    end;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    Caption = 'Payee Bank Code';
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    Caption = 'Payee Bank account No';
                    ApplicationArea = All;
                }
                field("Bank Name and Branch"; Rec."Bank Name and Branch")
                {
                    Caption = 'Branch';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Eft Generated"; Rec."Eft Generated")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = PostVisible;
                ApplicationArea = All;

                trigger OnAction()
                var
                //  PVPost: Codeunit 51511014;
                begin
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //charles
                    //TESTFIELD(Status,Status::Open);
                    Rec.RESET;
                    Rec.SETFILTER(No, Rec.No);
                // CASE Source OF
                //     Source::Imprest:
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Payment Voucher":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Imprest Claim":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Petty Cash Voucher":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Fund Disbursement":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                //     Source::"Director Payroll":
                //         BEGIN
                //             REPORT.RUN(Report::"Payment Vouchers", TRUE, TRUE, Rec);
                //         END;
                // END;
                // RESET;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF Rec.Status IN[Rec.Status::Released]THEN PostVisible:=TRUE
        ELSE
            PostVisible:=FALSE;
    end;
    trigger OnOpenPage()
    begin
        IF Rec.Status IN[Rec.Status::Released]THEN PostVisible:=TRUE
        ELSE
            PostVisible:=FALSE;
    end;
    var PostVisible: Boolean;
    UserSetup: Record "User Setup";
    // ImprestTrip: Record "Imprest Trip";
    // RequestHeader: Record "Request Header";
    BankLedger: Record "Bank Account Ledger Entry";
//  PVPosting: Codeunit "Payment- Post";
//  BoardOfDirectorsMeetings: Record "Board Of Directors Meetings";
}
