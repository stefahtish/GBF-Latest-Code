report 50110 "Store Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StoreRequest.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Internal Request Header"; "Internal Request Header")
        {
            column(No_InternalRequestHeader; "Internal Request Header"."No.")
            {
            }
            column(ReasonDescription_InternalRequestHeader; "Internal Request Header"."Reason Description")
            {
            }
            column(DocumentDate_InternalRequestHeader; "Internal Request Header"."Document Date")
            {
            }
            column(ExpectedReceiptDate_InternalRequestHeader; "Internal Request Header"."Expected Receipt Date")
            {
            }
            column(LocationCode_InternalRequestHeader; "Internal Request Header"."Location Code")
            {
            }
            column(PostingDate_InternalRequestHeader; "Internal Request Header"."Posting Date")
            {
            }
            column(CollectedBy_InternalRequestHeader; "Internal Request Header"."Collected By")
            {
            }
            column(RequestedBy_InternalRequestHeader; "Internal Request Header"."Requested By")
            {
            }
            column(PostedBy_InternalRequestHeader; "Internal Request Header"."Posted By")
            {
            }
            column(CollectedName_InternalRequestHeader; "Internal Request Header"."Collected Name")
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
            dataitem("Internal Request Line"; "Internal Request Line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(No_InternalRequestLine; "Internal Request Line"."No.")
                {
                }
                column(Description_InternalRequestLine; "Internal Request Line".Description)
                {
                }
                column(UnitofMeasure_InternalRequestLine; "Internal Request Line"."Unit of Measure")
                {
                }
                column(Quantity_InternalRequestLine; "Internal Request Line".Quantity)
                {
                }
                column(QtytoIssue_InternalRequestLine; "Internal Request Line"."Qty. to Issue")
                {
                }
                column(DirectUnitCost_InternalRequestLine; "Internal Request Line"."Direct Unit Cost")
                {
                }
                column(Amount_InternalRequestLine; "Internal Request Line".Amount)
                {
                }
                column(LineAmount_InternalRequestLine; "Internal Request Line"."Line Amount")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Approver[1] := "Internal Request Header"."Requested By";
                ApproverDate[1] := CreateDateTime("Internal Request Header"."Document Date", Time);
                if UserSetup.Get(Approver[1]) then UserSetup.CalcFields(Signature);
                ApprovalEntries.Reset;
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", 50126);
                ApprovalEntries.SetRange("Document No.", "Internal Request Header"."No.");
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
                //Get Header Dimensions
                DimSetEntry.Reset;
                DimSetEntry.SetRange("Dimension Set ID", "Internal Request Header"."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;
                DimSetEntry.Reset;
                DimSetEntry.SetRange("Dimension Set ID", "Internal Request Header"."Dimension Set ID");
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
        GLSetup: Record "General Ledger Setup";
        DimValueName: array[8] of Text;
        DimSetEntry: Record "Dimension Set Entry";
        PaymentTxt: Text;
        DimValueCode: array[8] of Code[20];
        HeaderDimValueName: array[8] of Text;
        HeaderDimValueCode: array[8] of Code[20];
        ApprovalEntries: Record "Approval Entry";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        i: Integer;
        CashMgt: Record "Cash Management Setups";

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
