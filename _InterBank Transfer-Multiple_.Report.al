report 50138 "InterBank Transfer-Multiple"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InterBankTransferMultiple.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Payments; Payments)
        {
            column(No_Payments; Payments."No.")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(ShortcutDimension1Code_Payments; Payments."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_Payments; Payments."Shortcut Dimension 2 Code")
            {
            }
            column(PaymentNarration_Payments; Payments."Payment Narration")
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(RecBankName; GetBankName(Payments."Account No."))
            {
            }
            column(ReceivingBankAmount_Payments; Payments."Receiving Bank Amount")
            {
            }
            column(SourceBank_Payments; Payments."Source Bank")
            {
            }
            column(SourceCurrency_Payments; Payments."Source Currency")
            {
            }
            column(SourceBankAmount_Payments; Payments."Source Bank Amount")
            {
            }
            column(SourceBankName; GetBankName(Payments."Source Bank"))
            {
            }
            column(ReceivingAmountLCY_Payments; Payments."Receiving Amount LCY")
            {
            }
            column(SourceAmountLCY_Payments; Payments."Source Amount LCY")
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
            column(Currency_Payments; Payments.Currency)
            {
            }
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
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = FIELD("No.");

                column(Currency_PaymentLines; "Payment Lines".Currency)
                {
                }
                column(AmountLCY_PaymentLines; "Payment Lines"."Amount (LCY)")
                {
                }
                column(AccountNo_PaymentLines; "Payment Lines"."Account No")
                {
                }
                column(AccountName_PaymentLines; "Payment Lines"."Account Name")
                {
                }
                column(Description_PaymentLines; "Payment Lines".Description)
                {
                }
                column(Amount_PaymentLines; "Payment Lines".Amount)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
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
                /*//Approvals
                ApprovalEntries.RESET;
                ApprovalEntries.SETRANGE("Table ID",50121);
                ApprovalEntries.SETRANGE("Document No.",Payments."No.");
                ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
                IF ApprovalEntries.FIND('-') THEN BEGIN
                   i:=0;
                 REPEAT
                 i:=i+1;
                IF i=1 THEN BEGIN
                  Approver[1]:=ApprovalEntries."Sender ID";
                ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
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
        CompanyInfo.CalcFields(Picture);
        GLSetup.Get;
        CashMgt.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        PaymentMgt: Codeunit "Payments Management";
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        i: Integer;
        strCopyText: Text;
        DimValueCode: array[8] of Code[50];
        HeaderDimValueName: array[8] of Text;
        HeaderDimValueCode: array[8] of Code[50];
        GLSetup: Record "General Ledger Setup";
        DimValueName: array[8] of Text;
        DimSetEntry: Record "Dimension Set Entry";
        CashMgt: Record "Cash Management Setups";

    local procedure GetBankName(BankCode: Code[50]): Text
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(BankCode) then exit(BankAccount.Name);
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        exit(UserCode);
    end;
}
