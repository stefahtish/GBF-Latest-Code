report 50109 "Staff Claim Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffClaimVoucher.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = WHERE("Payment Type" = CONST("Staff Claim"));
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
            column(PreparedBy; GetApproverName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetApproverName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetApproverName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetApproverName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(Approved5; GetApproverName(Approver[5]))
            {
            }
            column(DateApproved5; ApproverDate[5])
            {
            }
            column(Approver5_Signature; UserSetup3.Signature)
            {
            }
            column(Number_In_Words; NumberText[1])
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
            column(title; title)
            {
            }
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
                column(ClaimReceiptNo_PaymentLines; "Payment Lines"."Claim Receipt No.")
                {
                }
                column(ExpenditureDate_PaymentLines; "Payment Lines"."Expenditure Date")
                {
                }
                column(ExpenditureDescription_PaymentLines; "Payment Lines"."Expenditure Description")
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
                        //Anthony & Caro
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
                        DimValueName[2] := DimSetEntry."Dimension Value Name";
                        //Anthony & Caro
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
                    //Anthony&Caro
                    MultiDonor_Fund := '';
                    MultiDonor_Theme := '';
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if "Claim Type" = "Claim Type"::"General Claim" then
                    title := 'GENERAL CLAIM VOUCHER'
                else if "Claim Type" = "Claim Type"::Imprest then
                    title := 'IMPREST CLAIM VOUCHER'
                else if "Claim Type" = "Claim Type"::"Medical Claim" then
                    title := 'MEDICAL CLAIM VOUCHER'
                else if "Claim Type" = "Claim Type"::"Mileage Claim" then title := 'MILEAGE CLAIM VOUCHER';
                PaymentMgt.InitTextVariable;
                PaymentMgt.FormatNoText(NumberText, Payments."Petty Cash Amount", CurrencyCodeText);
                Approver[1] := Payments."Created By";
                ApproverDate[1] := CreateDateTime(Payments.Date, Payments."Time Inserted");
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
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                        end;
                    until ApprovalEntries.Next = 0;
                end;
                /*//Requsitioned By
                Approver[1]:=Payments."Created By";
                IF UserSetup.GET(Approver[1]) THEN
                    UserSetup.CALCFIELDS(Signature);
                
                
                //Approvals
                ApprovalEntries.RESET;
                ApprovalEntries.SETRANGE("Table ID",50121);
                ApprovalEntries.SETRANGE("Document No.",Payments."No.");
                ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
                IF ApprovalEntries.FIND('-') THEN BEGIN
                   i:=0;
                 REPEAT
                 i:=i+1;
                IF i=1 THEN BEGIN
                  //Approver[1]:=ApprovalEntries."Sender ID";
                //ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
                 IF UserSetup.GET(Approver[1]) THEN BEGIN
                   IF CashMgt."Append Sign To Documents"=TRUE THEN
                    UserSetup.CALCFIELDS(Signature);
                 END;
                
                Approver[2]:=ApprovalEntries."Approver ID";
                ApproverDate[2]:=ApprovalEntries."Last Date-Time Modified";
                 IF UserSetup1.GET(Approver[2]) THEN BEGIN
                   IF CashMgt."Append Sign To Documents"=TRUE THEN
                    UserSetup1.CALCFIELDS(Signature);
                 END;
                END;
                
                IF i=2 THEN
                BEGIN
                Approver[3]:=ApprovalEntries."Approver ID";
                ApproverDate[3]:=ApprovalEntries."Last Date-Time Modified";
                 IF UserSetup2.GET(Approver[3]) THEN BEGIN
                   IF CashMgt."Append Sign To Documents"=TRUE THEN
                    UserSetup2.CALCFIELDS(Signature);
                 END;
                END;
                
                IF i=3 THEN
                BEGIN
                Approver[4]:=ApprovalEntries."Approver ID";
                ApproverDate[4]:=ApprovalEntries."Last Date-Time Modified";
                 IF UserSetup3.GET(Approver[4]) THEN BEGIN
                   IF CashMgt."Append Sign To Documents"=TRUE THEN
                    UserSetup3.CALCFIELDS(Signature);
                 END;
                END;
                UNTIL
                ApprovalEntries.NEXT=0;
                
                END;*/
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
        Approver: array[50] of Code[50];
        ApproverDate: array[10] of DateTime;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        i: Integer;
        GLSetup: Record "General Ledger Setup";
        DimValueName: array[8] of Text;
        DimSetEntry: Record "Dimension Set Entry";
        MultiDonor_Fund: Text;
        MultiDonor_Theme: Text;
        DimValueCode: array[8] of Code[20];
        strCopyText: Text;
        CustomerBank: Record "Customer Bank Account";
        PaymentTxt: Text;
        HeaderDimValueName: array[8] of Text;
        HeaderDimValueCode: array[8] of Code[20];
        CashMgt: Record "Cash Management Setups";
        title: Text;
    // local procedure GetUserName(UserCode: Code[50]): Text
    // var
    //     Users: Record User;
    // begin
    //     Users.Reset;
    //     Users.SetRange("User Name", UserCode);
    //     if Users.FindFirst then
    //         exit(Users."User Name");
    // end;
    procedure GetApproverName(ApproverID: code[50]): Text
    var
        User: Record User;
    begin
        User.Reset();
        User.SetRange("User Name", ApproverID);
        if User.FindFirst() then exit(User."Full Name");
    end;
}
