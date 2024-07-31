report 50165 "Imprest Summary"
{
    DefaultLayout = Word;
    RDLCLayout = './ImprestSummary.rdl';
    WordLayout = './ImprestSummary.docx';
    Caption = 'Imprest Summary';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = WHERE("Payment Type" = FILTER(Imprest | "Service Charge"));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", Date, "Cheque No", Payee;

            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(No_Payments; Payments."No.")
            {
            }
            column(Imprest_Issue_Doc__No; "Imprest Issue Doc. No")
            {
            }
            column(DestinationName_Payments; Payments."Payment Narration")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PaymentsNarration; Payments."Payment Narration")
            {
            }
            column(BankName_Payments; Payments."Bank Name")
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(Payee_Payments; Payments.Payee)
            {
            }
            column(Onbehalfof_Payments; Payments."On behalf of")
            {
            }
            column(CreatedBy_Payments; Payments."Created By")
            {
            }
            column(Posted_Payments; Payments.Posted)
            {
            }
            column(PostedBy_Payments; Payments."Posted By")
            {
            }
            column(PostedDate_Payments; Payments."Posted Date")
            {
            }
            column(GlobalDimension1Code_Payments; Payments."Shortcut Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Payments; Payments."Shortcut Dimension 2 Code")
            {
            }
            column(TimePosted_Payments; Payments."Time Posted")
            {
            }
            column(TotalAmount_Payments; Payments."Total Amount")
            {
            }
            column(PayingBankAccount_Payments; Payments."Paying Bank Account")
            {
            }
            column(Status_Payments; Payments.Status)
            {
            }
            column(PaymentType_Payments; Payments."Payment Type")
            {
            }
            column(Currency_Payments; Payments.Currency)
            {
            }
            column(NoSeries_Payments; Payments."No. Series")
            {
            }
            column(AccountType_Payments; Payments."Account Type")
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(AccountName_Payments; Payments."Account Name")
            {
            }
            column(ImprestAmount_Payments; Payments."Imprest Amount")
            {
            }
            column(Surrendered_Payments; Payments.Surrendered)
            {
            }
            column(AppliesToDocNo_Payments; Payments."Applies- To Doc No.")
            {
            }
            column(PettyCashAmount_Payments; Payments."Petty Cash Amount")
            {
            }
            column(ImprestSurrenderDate_Payments; Payments."Surrender Date")
            {
            }
            column(DateFilter_Payments; Payments."Date Filter")
            {
            }
            column(StaffNo_Payments; Payments."Staff No.")
            {
            }
            column(DateofProject_Payments; Payments."Date of Project")
            {
            }
            column(DateofCompletion_Payments; Payments."Date of Completion")
            {
            }
            column(DueDate_Payments; Payments."Due Date")
            {
            }
            column(NoofDays_Payments; Payments."No of Days")
            {
            }
            column(Destination_Payments; Payments.Destination)
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(Number_In_Words; NumberText[1])
            {
            }
            column(strCopyText; strCopyText)
            {
            }
            column(ImprestBankName_Payments; CustomerBank.Name)
            {
            }
            column(ImprestBankBranchName_Payments; CustomerBank."Bank Branch No.")
            {
            }
            column(ImprestBankAccountNo_Payments; CustomerBank."Bank Account No.")
            {
            }
            column(Dim1; GLSetup."Global Dimension 1 Code")
            {
            }
            column(Dim2; GLSetup."Global Dimension 2 Code")
            {
            }
            column(Dim3; GLSetup."Shortcut Dimension 3 Code")
            {
            }
            column(Dim4; GLSetup."Shortcut Dimension 4 Code")
            {
            }
            column(Dim5; GLSetup."Shortcut Dimension 5 Code")
            {
            }
            column(Dim6; GLSetup."Shortcut Dimension 6 Code")
            {
            }
            column(Dim7; GLSetup."Shortcut Dimension 7 Code")
            {
            }
            column(MultiDonor; Payments."Multi-Donor")
            {
            }
            column(PaymentTxt; PaymentTxt)
            {
            }
            column(HeaderDimValueName_1; HeaderDimValueCode[1])
            {
            }
            column(HeaderDimValueName_2; HeaderDimValueCode[2])
            {
            }
            column(HeaderDimValueName_3; HeaderDimValueCode[3])
            {
            }
            column(HeaderDimValueName_4; HeaderDimValueCode[4])
            {
            }
            column(HeaderDimValueName_5; HeaderDimValueCode[5])
            {
            }
            column(HeaderDimValueName_6; HeaderDimValueCode[6])
            {
            }
            column(HeaderDimValueName_7; HeaderDimValueCode[7])
            {
            }
            column(HeaderDimValueName_8; HeaderDimValueCode[8])
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            // column(Activity_Work_Programme; "Activity Work Programme")
            // {
            // }
            // column(Work_Programme_Description; "Work Programme Description")
            // {
            // }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = FIELD("No.");
                DataItemTableView = SORTING(No, "Line No");

                column(No_ImprestLines; "Payment Lines".No)
                {
                }
                column(LineNo_ImprestLines; "Payment Lines"."Line No")
                {
                }
                column(AccountType_ImprestLines; "Payment Lines"."Account Type")
                {
                }
                column(AccountNo_ImprestLines; "Payment Lines"."Account No")
                {
                }
                column(AccountName_ImprestLines; "Payment Lines"."Account Name")
                {
                }
                column(Description_ImprestLines; "Payment Lines".Description)
                {
                }
                column(Amount_ImprestLines; "Payment Lines".Amount)
                {
                }
                column(AppliestoDocNo_ImprestLines; "Payment Lines"."Applies-to Doc. No.")
                {
                }
                column(GlobalDimension1Code_ImprestLines; "Payment Lines"."Shortcut Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_ImprestLines; "Payment Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(ActualSpent_ImprestLines; "Payment Lines"."Actual Spent")
                {
                }
                column(Expenditure_Date; "Expenditure Date")
                {
                }
                column(RemainingAmount_ImprestLines; "Payment Lines"."Remaining Amount")
                {
                }
                column(Committed_ImprestLines; "Payment Lines".Committed)
                {
                }
                column(AmountLCY_ImprestLines; "Payment Lines"."Actual Spent (LCY)")
                {
                }
                column(Purpose_ImprestLines; "Payment Lines".Purpose)
                {
                }
                column(ExpenditureType_PaymentLines; "Payment Lines"."Expenditure Type")
                {
                }
                column(DimValueName_1; DimValueName[1])
                {
                }
                column(DimValueName_2; DimValueName[2])
                {
                }
                column(DimValueName_3; DimValueName[3])
                {
                }
                column(DimValueName_4; DimValueName[4])
                {
                }
                column(DimValueName_5; DimValueName[5])
                {
                }
                column(DimValueName_6; DimValueName[6])
                {
                }
                column(DimValueName_7; DimValueName[7])
                {
                }
                column(DimValueName_8; DimValueName[8])
                {
                }
                column(MultiDonor_Fund; MultiDonor_Fund)
                {
                }
                column(MultiDonor_Theme; MultiDonor_Theme)
                {
                }
                column(DimValueCode_1; DimValueCode[1])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Dimension Values
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueCode[1] := DimSetEntry."Dimension Value Code";
                        DimValueName[1] := DimSetEntry."Dimension Value Name";
                        if Payments."Multi-Donor" then begin
                            if MultiDonor_Fund = '' then
                                MultiDonor_Fund := DimValueName[1]
                            else
                                MultiDonor_Fund := MultiDonor_Fund + ', ' + DimValueName[1];
                        end;
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueCode[2] := DimSetEntry."Dimension Value Code";
                        DimValueName[2] := DimSetEntry."Dimension Value Name";
                        if Payments."Multi-Donor" then begin
                            if MultiDonor_Theme = '' then
                                MultiDonor_Theme := DimValueName[2]
                            else
                                MultiDonor_Theme := MultiDonor_Theme + ', ' + DimValueName[2];
                        end;
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[3] := DimSetEntry."Dimension Value Name";
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[4] := DimSetEntry."Dimension Value Name";
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[5] := DimSetEntry."Dimension Value Name";
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[6] := DimSetEntry."Dimension Value Name";
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[7] := DimSetEntry."Dimension Value Name";
                    end;
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
                    if DimSetEntry.FindFirst then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[8] := DimSetEntry."Dimension Value Name";
                    end;
                    //
                end;

                trigger OnPreDataItem()
                begin
                    MultiDonor_Fund := '';
                    MultiDonor_Theme := '';
                end;
            }
            trigger OnAfterGetRecord()
            begin
                PaymentMgt.InitTextVariable;
                PaymentMgt.FormatNoText(NumberText, "Imprest Amount", CurrencyCodeText);
                //daudi
                if Payments."No. Printed" = 0 then
                    strCopyText := 'ORIGINAL'
                else if Payments."No. Printed" = 1 then
                    strCopyText := 'DUPLICATE'
                else if Payments."No. Printed" > 2 then strCopyText := 'TRIPLICATE';
                //Approvals
                Approver[1] := Payments."Created By";
                ApproverDate[1] := CreateDateTime(Payments.Date, Payments."Time Inserted");
                if UserSetup.Get(Approver[1]) then UserSetup.CalcFields(Signature);
                ApprovalEntries.Reset;
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", 50121);
                ApprovalEntries.SetRange("Document No.", Payments."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
                CustomerBank.Reset;
                CustomerBank.SetRange("Customer No.", Payments."Account No.");
                if CustomerBank.Find('-') then;
                PaymentTxt := 'IMPREST REQUSITION';
                //Get Header Dimensions
                DimSetEntry.Reset;
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;
                DimSetEntry.Reset;
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                if DimSetEntry.FindFirst then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[2] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[2] := DimSetEntry."Dimension Value Name";
                end;
                GLSetup.Get;
                if Payments.Currency = '' then
                    CurrencyCode := GLSetup."LCY Code"
                else
                    CurrencyCode := Payments.Currency;
            end;

            trigger OnPreDataItem()
            begin
                Payments.CalcFields("Imprest Amount");
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        GLSetup.Get();
        CashMgt.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text;
        TTotal: Decimal;
        PaymentMgt: Codeunit "Payments Management";
        CurrencyCodeText: Code[10];
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[30];
        ApproverDate: array[10] of DateTime;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        i: Integer;
        strCopyText: Text;
        CustomerBank: Record "Customer Bank Account";
        GLSetup: Record "General Ledger Setup";
        DimValueName: array[8] of Text;
        DimSetEntry: Record "Dimension Set Entry";
        MultiDonor_Fund: Text;
        MultiDonor_Theme: Text;
        PaymentTxt: Text;
        DimValueCode: array[8] of Code[20];
        HeaderDimValueName: array[8] of Text;
        HeaderDimValueCode: array[8] of Code[20];
        CashMgt: Record "Cash Management Setups";
        CurrencyCode: Code[10];

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;
}
