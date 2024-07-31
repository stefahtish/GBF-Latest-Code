report 50304 "Purchase Request"
{
    DefaultLayout = RDLC;
    //  RDLCLayout = './PurchaseRequest.rdlc';
    RDLCLayout = './Report/Report 51519803 Purchase Request.rdl';
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
            column(OrderDate_InternalRequestHeader; "Internal Request Header"."Order Date")
            {
            }
            column(ProcurementPlan_InternalRequestHeader; "Internal Request Header"."Procurement Plan")
            {
            }
            column(EmployeeNo_InternalRequestHeader; "Internal Request Header"."Employee No.")
            {
            }
            column(EmployeeName_InternalRequestHeader; "Internal Request Header"."Employee Name")
            {
            }
            column(Department; "Internal Request Header"."Shortcut Dimension 2 Code")
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
            column(ExecutiveDirector; GetUserName(Approver[5]))
            {
            }
            column(ExecSignature; UserSetup3.Signature)
            {
            }
            column(ExecDate; ApproverDate[5])
            {
            }
            column(IsExecutive; IsExecutive)
            {
            }
            column(TimePrepared; TimePrepared)
            {
            }
            column(TimeExamined; TimeExamined)
            {
            }
            column(TimeVBC; TimeVBC)
            {
            }
            column(TimeAuthorized; TimeAuthorized)
            {
            }
            column(TimeExecutiveDirector; TimeExecutiveDirector)
            {
            }
            column(ISO; ISOCert)
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
                column(ProcurementPlanItem_InternalRequestLine; "Internal Request Line"."Procurement Plan Item")
                {
                }
                column(Type_InternalRequestLine; "Internal Request Line".Type)
                {
                }
                column(Specifications_InternalRequestLine; SNotesText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Policy Exclusion
                    CALCFIELDS(Specification2);
                    Specification2.CREATEINSTREAM(Instr);
                    SNotes.READ(Instr);
                    SNotesText := FORMAT(SNotes);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Approver[1] := "Internal Request Header"."Requested By";
                ApproverDate[1] := CreateDateTime("Internal Request Header"."Document Date", Time);
                TimePrepared := DT2Time("Internal Request Header".SystemCreatedAt);
                ApprovalEntries.Reset;
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", 50126);
                ApprovalEntries.SetRange("Document No.", "Internal Request Header"."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    begin
                        repeat
                            if ApprovalEntries."Sequence No." = 1 then begin
                                Approver[2] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                                TimeExamined := DT2Time(ApprovalEntries."Last Date-Time Modified");
                            end;
                            if ApprovalEntries."Sequence No." = 2 then begin
                                Approver[3] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                                TimeVBC := DT2Time(ApprovalEntries."Last Date-Time Modified");
                            end;
                            if ApprovalEntries."Sequence No." = 3 then begin
                                Approver[4] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                                TimeAuthorized := DT2Time(ApprovalEntries."Last Date-Time Modified");
                            end;
                            if ApprovalEntries."Sequence No." = 4 then begin
                                Approver[5] := ApprovalEntries."Last Modified By User ID";
                                ApproverDate[5] := ApprovalEntries."Last Date-Time Modified";
                                TimeExecutiveDirector := DT2Time(ApprovalEntries."Last Date-Time Modified");
                            end;
                        until ApprovalEntries.Next = 0;
                    end;
                end;
                /*//Approvals
                ApprovalEntries.RESET;
                ApprovalEntries.SETRANGE("Table ID",51519009);
                ApprovalEntries.SETRANGE("Document No.","Internal Request Header"."No.");
                //ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
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
                
                ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
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
                DynamicallyAssignApproverusers();
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
    trigger OnInitReport()
    begin
        if CompanyName = 'KUC' then
            ISOCert := ISOText
        else
            ISOCert := '';
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        GLSetup.Get;
        CashMgt.Get;
    end;

    var
        SNotes: BigText;
        SNotesText: Text;
        Instr: InStream;
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
        UserSetup4: Record "User Setup";
        i: Integer;
        CashMgt: Record "Cash Management Setups";
        ISOCert: Text;
        ISOText: Label '';
        IsExecutive: Boolean;
        TimeRaised: Time;
        TimePrepared: Time;
        TimeExamined: Time;
        TimeVBC: Time;
        TimeAuthorized: Time;
        TimeExecutiveDirector: Time;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        Users.Reset;
        Users.SetRange("User Name", UserCode);
        if Users.FindFirst then exit(Users."Full Name");
    end;
    //   Procedure to dynamically Assign Approver Users if workflow user group sequence does not have value:
    procedure DynamicallyAssignApproverusers()
    var
        DyamicApprover: array[10] of Code[50];
        DynamicApproverDate: array[10] of DateTime;
        DynamicPrepared: Time;
        DynamicExamined: Time;
        DynamicVBC: Time;
        DynamicAuthorized: Time;
        DynamicExec: Time;
    begin
        IsExecutive := false;
        DyamicApprover[1] := Approver[1];
        DynamicApproverDate[1] := ApproverDate[1];
        DynamicPrepared := TimePrepared;
        DyamicApprover[2] := Approver[2];
        DynamicApproverDate[2] := ApproverDate[2];
        DynamicExamined := TimeExamined;
        DyamicApprover[4] := Approver[3];
        DynamicApproverDate[4] := ApproverDate[3];
        DynamicAuthorized := TimeVBC;
        DyamicApprover[5] := Approver[4];
        DynamicApproverDate[5] := ApproverDate[4];
        DynamicExec := TimeAuthorized;
        DyamicApprover[3] := '';
        DynamicApproverDate[3] := 0DT;
        DynamicVBC := 0T;
        if Approver[5] = '' then begin
            IsExecutive := true;
            Approver[1] := DyamicApprover[1];
            ApproverDate[1] := DynamicApproverDate[1];
            TimePrepared := DynamicPrepared;
            Approver[2] := DyamicApprover[2];
            ApproverDate[2] := DynamicApproverDate[2];
            TimeExamined := DynamicExamined;
            Approver[3] := DyamicApprover[3];
            ApproverDate[3] := DynamicApproverDate[3];
            TimeVBC := DynamicVBC;
            Approver[4] := DyamicApprover[4];
            ApproverDate[4] := DynamicApproverDate[4];
            TimeAuthorized := DynamicAuthorized;
            Approver[5] := DyamicApprover[5];
            ApproverDate[5] := DynamicApproverDate[5];
            TimeExecutiveDirector := DynamicExec;
        end;
    end;
}
