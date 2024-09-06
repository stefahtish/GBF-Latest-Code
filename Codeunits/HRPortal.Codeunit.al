codeunit 50150 HRPortal
{
    Permissions = tabledata 454 = RIMD;

    [ServiceEnabled]
    procedure PrintPayslip(employeeNo: Code[20]; Period: Date) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetPayslip(employeeNo, Period) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    internal procedure GetPayslip(employeeno: Code[20]; period: Date)
    var
        BaseImage: Text;
        filename: Text;
        PeriodText: Text;
    begin

        // PeriodText := DelChr(Format(Period), '=', '/|:');
        // filename := Path + 'PaySlip_' + PeriodText + '-' + EmployeeNo + '.pdf';
        TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Employee.Reset;
        Employee.SetRange("No.", EmployeeNo);
        Employee.SetRange("Pay Period Filter", Period);
        if Employee.Find('-') then begin
            RecRef.GetTable(Employee);
            Report.SaveAs(Report::"New Payslipx-Self Service", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('PAYSLIP_%1.Pdf', Employee."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', BaseImage);
        end;
    end;

    [ServiceEnabled]
    procedure PrintP9(employeeNo: Code[20]; Year: Integer) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetP9(employeeNo, Year) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    internal procedure GetP9(employeeno: Code[20]; year: Integer)
    var
        BaseImage: Text;
    begin
        TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Employee.Reset;
        Employee.SetRange("No.", EmployeeNo);
        if Employee.Find('-') then begin
            RecRef.GetTable(Employee);
            Report.SaveAs(Report::"P9A Report-Self Service", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('P9_%1.Pdf', Employee."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', BaseImage);
        end;
    end;

    [ServiceEnabled]
    procedure PrintEmloyeeStatement(employeeNo: Code[20]) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetEmloyeeStatement(employeeNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    internal procedure GetEmloyeeStatement(employeeno: Code[20])
    var
        BaseImage: Text;
    begin
        TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Employee.Reset();
        Employee.SetRange(Employee."No.", employeeno);
        //Employee.SetFilter("Mode of Study", '%1', studyMode);
        if Employee.Find('-') then begin
            RecRef.GetTable(Employee);
            Report.SaveAs(Report::"Standard Statement", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('CUSTOMERSTATEMENT_%1.Pdf', Employee."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', BaseImage);
        end;
    end;

    [ServiceEnabled]
    procedure fnGetEmployeeDetails(employeeNo: Code[20]) RtnV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not fnGetEmployeeDetail(employeeNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    internal procedure fnGetEmployeeDetail(empNumber: Code[30])
    begin
        Employee.Reset();
        Employee.SetRange("No.", empNumber);
        if Employee.FindSet(true) then begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('First_Name', Employee."First Name");
            JsObject.Add('Last_Name', Employee."First Name");
            JsObject.Add('Middle_Name', Employee."First Name");
        end else begin
            Error('Employee No does not exist');
        end;
    end;

    [ServiceEnabled]
    procedure FnCreateLeaveApplication(leaveNo: Code[20]; employeeNo: Code[20]; leaveType: Code[20]; annualLeaveType: Integer; days: Decimal; startDate: Date; reliever: Code[20]; remarks: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitLeaveApplication(leaveNo, employeeNo, leaveType, annualLeaveType, days, startDate, reliever, remarks) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    internal procedure SubmitLeaveApplication(leaveNo: Code[20]; employeeNo: Code[20]; leaveType: Code[20]; annualLeaveType: Integer; days: Decimal; startDate: Date; reliever: Code[20]; remarks: Text)
    var
        leaveApplications: Record "Leave Application";
        LeaveReliever: Record "Leave Relievers";
    begin
        if leaveNo = '' then begin
            leaveApplications.Reset();
            leaveApplications.SetRange(Status, leaveApplications.Status::Open);
            leaveApplications.SetRange("Employee No", employeeNo);
            if leaveApplications.FindSet(true) then begin
                Error('Sorry, you already have an open leave application. Kindly use it.');
            end else begin
                leaveApplications.Init;
                leaveApplications."Employee No" := employeeNo;
                leaveApplications.VALIDATE("Employee No");
                leaveApplications."Leave Code" := leaveType;
                leaveApplications.VALIDATE("Leave Code");
                leaveApplications."Days Applied" := days;
                leaveApplications."Start Date" := startDate;
                leaveApplications.VALIDATE("Start Date");
                leaveApplications."Reliever No." := reliever;
                if reliever <> '' then
                    leaveApplications."Leave Reliever" := true;

                leaveApplications.VALIDATE("Reliever No.");
                If leaveApplications.Insert(true) then begin
                    LeaveReliever.Init();
                    LeaveReliever."Leave Code" := leaveApplications."Application No";
                    LeaveReliever."Staff No" := reliever;
                    LeaveReliever.Validate("Staff No");
                    LeaveReliever.Insert(true);

                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', leaveApplications."Application No");
                    JsObject.Add('ReturnDate', FORMAT(leaveApplications."Resumption Date"));
                    JsObject.Add('Message', 'The leave application was successfull');

                end ELSE BEGIN
                    Error('The leave application was unsuccessful. Kindly try again later');
                END;
            end;
        end ELSE BEGIN
            leaveApplications.RESET;
            leaveApplications.SETRANGE("Application No", leaveNo);
            leaveApplications.SETRANGE("Employee No", employeeNo);
            IF leaveApplications.FINDSET THEN BEGIN
                leaveApplications."Employee No" := employeeNo;
                leaveApplications.VALIDATE("Employee No");
                leaveApplications."Leave Code" := leaveType;
                leaveApplications.VALIDATE("Leave Code");
                leaveApplications."Days Applied" := days;
                leaveApplications."Start Date" := startDate;
                leaveApplications.VALIDATE("Start Date");
                leaveApplications."Reliever No." := reliever;
                if reliever <> '' then
                    leaveApplications."Leave Reliever" := true;
                leaveApplications.VALIDATE("Reliever No.");
                IF leaveApplications.MODIFY(TRUE) THEN BEGIN
                    LeaveReliever.Init();
                    LeaveReliever."Leave Code" := leaveApplications."Application No";
                    LeaveReliever."Staff No" := reliever;
                    LeaveReliever.Validate("Staff No");
                    LeaveReliever.Insert(true);
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', leaveApplications."Application No");
                    JsObject.Add('ReturnDate', FORMAT(leaveApplications."Resumption Date"));
                    JsObject.Add('Message', 'The leave application was successfull');

                end ELSE BEGIN
                    Error('The leave application was unsuccessful. Kindly try again later');
                END;
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnCreateImprestRequisition(requisitionNo: Code[20]; empNo: Code[20]; referenceNo: Text; paymentNarration: Text; destination: Code[20]; department: Code[20]; projectCode: Code[20]; startDate: Date; returnDate: Date) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitImprestRequisition(requisitionNo, empNo, referenceNo, paymentNarration, destination, department, projectCode, startDate, returnDate) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitImprestRequisition(requisitionNo: Code[20]; empNo: Code[20]; referenceNo: Text; paymentNarration: Text; destination: Code[20]; department: Code[20]; projectCode: Code[20]; startDate: Date; returnDate: Date)
    var
        payments: Record Payments;
        employee: Record Employee;
        myTextDate: Text;
        myDate: Date;
    begin
        myTextDate := '0001-01-01';
        Evaluate(myDate, myTextDate);

        if requisitionNo = '' then begin
            payments.Reset();
            payments.Init;
            payments."Staff No." := empNo;
            employee.Reset();
            employee.Get(empNo);
            if employee.findset then begin
                payments.payee := employee."First Name" + ' ' + employee."Last Name";
                payments.Payee := employee."First Name" + ' ' + employee."Last Name";
                payments."Account No." := employee."Imprest Customer Code";
                payments."Account Name" := employee."First Name" + ' ' + employee."Last Name";

            end;
            payments."Portal Request" := true;
            payments.Destination := destination;
            payments."Shortcut Dimension 1 Code" := projectCode;
            payments."Shortcut Dimension 2 Code" := department;
            payments."Payment Type" := payments."Payment Type"::Imprest;
            payments."Account Type" := payments."Account Type"::Customer;
            payments."Payment Narration" := paymentNarration;
            if (startDate <> myDate) then begin
                payments."Date of Project" := startDate;
                payments."Travel Date" := startDate;
            end;

            if (returnDate <> myDate) then begin
                payments."Date of Completion" := returnDate;
            end;

            payments.Date := Today;
            payments."Time Inserted" := Time;
            // payments.Validate("Account No.");          
            payments.Status := payments.Status::Open;
            if payments.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', payments."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            // modify
            payments.reset;
            payments.setrange(payments."Staff No.", empNo);
            payments.setrange("No.", requisitionNo);
            payments.setrange(Status, payments.Status::Open);
            if payments.findset(true) then begin
                payments."Shortcut Dimension 1 Code" := projectCode;
                payments."Shortcut Dimension 2 Code" := department;
                payments."Payment Narration" := paymentNarration;
                payments.Destination := destination;
                if (startDate <> myDate) then begin
                    payments."Date of Project" := startDate;
                    payments."Travel Date" := startDate;
                end;
                if (returnDate <> myDate) then begin
                    payments."Date of Completion" := returnDate;
                end;

                if payments.Modify(true) then begin
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', payments."No.");
                end else begin
                    Error('Sorry, an error occurred while modifying your request. Kindly try agaun');
                end;
            end else begin
                Error('Sorry, the requisition does not belong to you or is not open. Kindly contact the administrator.');
            end;
        end;



    end;

    [ServiceEnabled]
    procedure FnCreateImprestLine(empNo: Code[20]; imprestNo: Code[20]; expenditureType: Code[50]; projectNo: Code[20]; taskNo: Code[20]; imprestAmount: Decimal) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitImprestLine(empNo, imprestNo, expenditureType, projectNo, taskNo, imprestAmount) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitImprestLine(empNo: Code[20]; imprestNo: Code[20]; expenditureType: Code[50]; projectNo: Code[20]; taskNo: Code[20]; imprestAmount: Decimal)
    var
        payments: Record Payments;
        imprestLines: Record "Payment Lines";
        LineNo: Integer;

    begin

        payments.Reset();
        payments.setrange("No.", imprestNo);
        payments.setrange("Staff No.", empNo);
        payments.setrange(Status, payments.Status::Open);
        if payments.findset(true) then begin
            imprestLines.Reset();
            imprestLines.SetRange("No", imprestNo);
            if imprestLines.FindLast() then
                LineNo := imprestLines."Line No" + 10000
            else
                LineNo := 10000;

            imprestLines.init;
            imprestLines.No := imprestNo;
            imprestLines.Validate(No);
            imprestLines."Line No" := LineNo;
            imprestLines."Expenditure Type" := expenditureType;
            imprestLines.Validate("Expenditure Type");
            imprestLines.Amount := ImprestAmount;
            imprestLines.Validate(Amount);
            imprestLines."Job No." := projectNo;
            imprestLines."Job Task No." := taskNo;
            if imprestLines.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', payments."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again');
            end;

        end else begin
            Error('Sorry, you could not add an imprest line. The imprest request is either not open or you are not the requestor. Kindly contact the administrator if this error persists.');
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteImprestLine(imprestNo: Code[20]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteImprestLine(imprestNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure DeleteImprestLine(imprestNo: Code[20]; lineNo: Integer)
    var
        imprestLines: Record "Payment Lines";

    begin

        imprestLines.Reset();
        imprestLines.setrange(No, imprestNo);
        imprestLines.setrange("Line No", lineNo);
        if imprestLines.findfirst() then begin
            if imprestLines.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', imprestLines."No");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again');
            end;
        end else begin
            Error('Sorry, you could not find the imprest line. Kindly contact the administrator if this error persists.');
        end;

    end;

    [ServiceEnabled]
    procedure FnCreateImprestSurrender(surrenderNo: Code[20]; empNo: Code[20]; imprestNo: Code[20]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitImprestSurrender(surrenderNo, empNo, imprestNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitImprestSurrender(surrenderNo: Code[20]; empNo: Code[20]; imprestNo: Code[20])
    var
        payments: Record Payments;
        employee: Record Employee;
    begin
        if surrenderNo = '' then begin
            payments.Reset;
            payments.Init;
            payments."Staff No." := empNo;
            employee.Reset();
            employee.Get(empNo);
            if employee.findset then begin
                payments.payee := employee."First Name" + ' ' + employee."Last Name";
                payments."Account Name" := employee."First Name" + ' ' + employee."Last Name";
            end;
            payments."Payment Type" := payments."Payment Type"::"Imprest Surrender";
            payments."Imprest Issue Doc. No" := imprestNo;
            payments."Portal Request" := true;
            payments.Date := Today;
            payments."Surrender Date" := Today;
            payments."Posting Date" := Today;
            payments.Status := payments.Status::Open;
            if payments.Insert(true) then begin
                payments.validate("Imprest Issue Doc. No");
                payments.Modify(true);
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', payments."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            // modify
            payments.reset;
            payments.setrange(payments."Staff No.", empNo);
            payments.setrange("No.", surrenderNo);
            payments.setrange(Status, payments.Status::Open);
            if payments.findset(true) then begin
                payments."Payment Type" := payments."Payment Type"::"Imprest Surrender";
                payments."Portal Request" := true;
                payments."Imprest Issue Doc. No" := imprestNo;
                payments.validate("Imprest Issue Doc. No");
                payments.Date := Today;
                if payments.Modify(true) then begin
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', payments."No.");
                end else begin
                    Error('Sorry, an error occurred while modifying your request. Kindly try agaun');
                end;
            end else begin
                Error('Sorry, the requisition does not belong to you or is not open. Kindly contact the administrator.');
            end;
        end;



    end;

    [ServiceEnabled]
    procedure FnUpdateImprestSurrenderLine(empNo: Code[20]; imprestNo: Code[20]; actualAmount: Decimal; lineNo: Integer; comments: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitImprestSurrenderLine(empNo, imprestNo, actualAmount, lineNo, comments) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitImprestSurrenderLine(empNo: Code[20]; imprestNo: Code[20]; actualAmount: Decimal; lineNo: Integer; comments: Text)
    var
        payments: Record Payments;
        imprestLines: Record "Payment Lines";

    begin

        payments.Reset();
        payments.setrange("No.", imprestNo);
        payments.setrange("Staff No.", empNo);
        payments.setrange(Status, payments.Status::Open);
        if payments.findset(true) then begin
            imprestLines.Reset();
            imprestLines.setrange("No", imprestNo);
            imprestLines.setrange("Line No", LineNo);
            if imprestLines.findset(true) then begin
                imprestLines."Actual Spent" := ActualAmount;
                imprestLines.Validate("Actual Spent");
                imprestLines.Comments := Comments;
                if imprestLines.Modify(true) then begin
                    imprestLines.Validate("Account No");
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', payments."No.");
                end else begin
                    Error('Sorry, an error occurred while processing your request. Kindly try agaun');
                end;

            end else begin
                Error('Sorry, you could not add an imprest surrender line. The imprest surrender request is either not open or you are not the requestor. Kindly contact the administrator if this error persists.');
            end;

        end else begin
            Error('Sorry, you could not add an imprest surrender line. The imprest surrender request is either not open or you are not the requestor. Kindly contact the administrator if this error persists.');
        end;


    end;

    [ServiceEnabled]
    procedure FnCreateStaffClaimRequisition(requisitionNo: Code[20]; empNo: Code[20]; claimType: Integer; department: Code[20]; projectCode: Code[20]; paymentNarration: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitStaffClaimRequisition(requisitionNo, empNo, claimType, department, projectCode, paymentNarration) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitStaffClaimRequisition(requisitionNo: Code[20]; empNo: Code[20]; claimType: Integer; department: Code[20]; projectCode: Code[20]; paymentNarration: Text)
    var
        payments: Record Payments;
        employee: Record Employee;
    begin
        if requisitionNo = '' then begin
            payments.Reset;
            payments.Init;
            payments."Staff No." := empNo;
            employee.Reset();
            employee.Get(empNo);
            if employee.findset then begin
                payments.payee := employee."First Name" + ' ' + employee."Last Name";
                payments."Account Name" := employee."First Name" + ' ' + employee."Last Name";
            end;
            payments."Portal Request" := true;
            payments."Payment Type" := payments."Payment Type"::"Staff Claim";
            payments."Payment Narration" := paymentNarration;
            payments."Shortcut Dimension 1 Code" := projectCode;
            payments."Shortcut Dimension 2 Code" := department;
            payments."Claim Type" := claimType;
            payments.Validate("Claim Type");
            payments.Date := Today;
            payments."Account Type" := payments."Account Type"::Employee;
            payments.Status := payments.Status::Open;
            if payments.Insert(true) then begin
                payments.Modify();
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', payments."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            // modify
            payments.reset;
            payments.setrange(payments."Staff No.", empNo);
            payments.setrange("No.", requisitionNo);
            payments.setrange(Status, payments.Status::Open);
            if payments.findset(true) then begin
                payments."Payment Narration" := paymentNarration;
                payments."Shortcut Dimension 1 Code" := projectCode;
                payments."Shortcut Dimension 2 Code" := department;
                payments."Claim Type" := claimType;
                payments.Validate("Claim Type");
                if payments.Modify(true) then begin

                    payments.Modify();
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', payments."No.");
                end else begin
                    Error('Sorry, an error occurred while modifying your request. Kindly try agaun');
                end;
            end else begin
                Error('Sorry, the requisition does not belong to you or is not open. Kindly contact the administrator.');
            end;
        end;



    end;

    [ServiceEnabled]
    procedure FnCreateStaffClaimLine(empNo: Code[20]; docNo: Code[20]; expenditureType: Code[20]; projectNo: Code[20]; taskNo: Code[20]; claimAmount: Decimal; expenditureDate: Date; expenditureDescr: Text; remarks: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitStaffClaimLine(empNo, docNo, expenditureType, projectNo, taskNo, claimAmount, expenditureDate, expenditureDescr, remarks) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitStaffClaimLine(empNo: Code[20]; docNo: Code[20]; expenditureType: Code[20]; projectNo: Code[20]; taskNo: Code[20]; claimAmount: Decimal; expenditureDate: Date; expenditureDescr: Text; remarks: Text)
    var
        payments: Record Payments;
        paymentLines: Record "Payment Lines";
        LineNo: Integer;

    begin

        payments.Reset();
        payments.setrange("No.", docNo);
        payments.setrange("Staff No.", empNo);
        payments.setrange(Status, payments.Status::Open);
        if payments.findset(true) then begin

            paymentLines.Reset();
            paymentLines.SetRange("No", docNo);
            if paymentLines.FindLast() then
                LineNo := paymentLines."Line No" + 10000
            else
                LineNo := 10000;

            paymentLines.init;
            paymentLines."Line No" := LineNo;
            paymentLines."Account Type" := paymentLines."Account Type"::"G/L Account";
            paymentLines.Validate("Account Type");
            paymentLines."Expenditure Type" := expenditureType;
            paymentLines.No := docNo;
            paymentLines.Validate(No);
            paymentLines.Validate("Expenditure Type");
            paymentLines.Amount := claimAmount;
            paymentLines.Validate(Amount);
            paymentLines."Expenditure Date" := expenditureDate;
            paymentLines."Expenditure Description" := expenditureDescr;
            paymentLines.Remarks := remarks;
            paymentLines."Job No." := projectNo;
            paymentLines."Job Task No." := taskNo;
            if paymentLines.Insert(true) then begin
                paymentLines.Validate("Account No");
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', payments."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try agaun');
            end;

        end else begin
            Error('Sorry, you could not add an staff claim line. The staff claim request is either not open or you are not the requestor. Kindly contact the administrator if this error persists.');
        end;



    end;

    [ServiceEnabled]
    procedure FnDeleteStaffClaimLine(docNo: Code[20]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteStaffClaimLine(docNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure DeleteStaffClaimLine(docNo: Code[20]; lineNo: Integer)
    var
        staffClaimLines: Record "Payment Lines";

    begin

        staffClaimLines.Reset();
        staffClaimLines.setrange(No, docNo);
        staffClaimLines.setrange("Line No", lineNo);
        if staffClaimLines.findfirst() then begin
            if staffClaimLines.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', staffClaimLines."No");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again');
            end;
        end else begin
            Error('Sorry, you could not find the staff claim line. Kindly contact the administrator if this error persists.');
        end;

    end;

    [ServiceEnabled]
    procedure FnCreatePurchaseRequisition(requisitionNo: Code[20]; empNo: Code[20]; projectCode: Code[20]; departmentCode: Code[20]; reasonDescr: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitPurchaseRequisition(requisitionNo, empNo, projectCode, departmentCode, reasonDescr) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitPurchaseRequisition(requisitionNo: Code[20]; empNo: Code[20]; projectCode: Code[20]; departmentCode: Code[20]; reasonDescr: Text)
    var
        purchase: Record "Internal Request Header";
        employee: Record Employee;
    begin
        if requisitionNo = '' then begin
            purchase.Reset;
            purchase.Init;
            purchase."Employee No." := empNo;
            purchase.Validate("Employee No.");
            //purchase."Portal Request" := true;
            purchase."Document Type" := purchase."Document Type"::Purchase;
            purchase."Reason Description" := reasonDescr;
            purchase."Shortcut Dimension 1 Code" := projectCode;
            purchase."Shortcut Dimension 2 Code" := departmentCode;
            purchase."Document Date" := Today;
            purchase."Order Date" := Today;
            purchase.Status := purchase.Status::Open;
            if purchase.Insert(true) then begin
                purchase.Modify();
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', purchase."No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            // Update
            purchase.reset;
            purchase.setrange(purchase."Employee No.", empNo);
            purchase.setrange("No.", requisitionNo);
            purchase.setrange(Status, purchase.Status::Open);
            if purchase.findset(true) then begin
                purchase."Document Type" := purchase."Document Type"::Purchase;
                purchase."Reason Description" := reasonDescr;
                purchase."Shortcut Dimension 1 Code" := projectCode;
                purchase."Shortcut Dimension 2 Code" := departmentCode;
                purchase."Document Date" := Today;
                purchase."Order Date" := Today;
                if purchase.Modify(true) then begin
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', purchase."No.");
                end else begin
                    Error('Sorry, an error occurred while modifying your request. Kindly try agaun');
                end;
            end else begin
                Error('Sorry, the requisition does not belong to you or is not open. Kindly contact the administrator.');
            end;
        end;



    end;

    [ServiceEnabled]
    procedure FnCreatePurchaseLine(empNo: Code[20]; docNo: Code[20]; quantity: Decimal; description: Text; unitofMeasure: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitPurchaseLine(empNo, docNo, quantity, description, unitofMeasure) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitPurchaseLine(empNo: Code[20]; docNo: Code[20]; quantity: Decimal; description: Text; unitofMeasure: Code[30])
    var
        purchase: Record "Internal Request Header";
        purchaseLines: Record "Internal Request Line";
        LineNo: Integer;

    begin

        purchase.Reset();
        purchase.setrange("No.", docNo);
        purchase.setrange("Employee No.", empNo);
        purchase.setrange(Status, purchase.Status::Open);
        if purchase.findset(true) then begin

            purchaseLines.Reset();
            purchaseLines.SetRange("Document No.", docNo);
            if purchaseLines.FindLast() then
                LineNo := purchaseLines."Line No." + 10000
            else
                LineNo := 10000;

            purchaseLines.init;
            purchaseLines."Document Type" := purchaseLines."Document Type"::Purchase;
            purchaseLines."Document No." := docNo;
            purchaseLines.Validate("Document No.");
            purchaseLines."Line No." := LineNo;
            purchaseLines.Type := purchaseLines.Type::Item;
            purchaseLines.Validate(Type);
            purchaseLines."No." := '1001';
            purchaseLines.Validate("No.");
            purchaseLines."Unit of Measure" := unitofMeasure;
            purchaseLines.Quantity := quantity;
            purchaseLines.Validate(Quantity);
            purchaseLines.Description := description;
            if purchaseLines.Insert(true) then begin

                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', purchaseLines."Line No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try agaun');
            end;

        end else begin
            Error('Sorry, you could not add purchase line. The purchase request is either not open or you are not the requestor. Kindly contact the administrator if this error persists.');
        end;



    end;

    [ServiceEnabled]
    procedure FnDeletePurchaseLine(docNo: Code[20]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeletePurchaseLine(docNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure DeletePurchaseLine(docNo: Code[20]; lineNo: Integer)
    var
        purchaseLines: Record "Internal Request Line";

    begin

        purchaseLines.Reset();
        purchaseLines.setrange("Document No.", docNo);
        purchaseLines.setrange("Line No.", lineNo);
        if purchaseLines.findfirst() then begin
            if purchaseLines.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', purchaseLines."Document No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again');
            end;
        end else begin
            Error('Sorry, you could not find the purchase line. Kindly contact the administrator if this error persists.');
        end;

    end;

    [ServiceEnabled]
    procedure FnCreateTrainingRequisition(requisitionNo: Code[20]; empNo: Code[20]; trainingNeed: Code[20]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitTrainingRequisition(requisitionNo, empNo, trainingNeed) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SubmitTrainingRequisition(requisitionNo: Code[20]; empNo: Code[20]; trainingNeed: Code[20])
    var
        training: Record "Training Request";
        employee: Record Employee;
    begin
        if requisitionNo = '' then begin
            training.Reset;
            training.Init;
            training."Employee No" := empNo;
            training.Validate("Employee No");
            //training."Portal Request" := true;           
            training."Training Need" := trainingNeed;
            training.Validate("Training Need");
            training."Request Date" := Today;
            training.Status := training.Status::Open;
            if training.Insert(true) then begin
                training.Modify();
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', training."Request No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            // modify
            training.reset;
            training.setrange(training."Employee No", empNo);
            training.setrange("Request No.", requisitionNo);
            training.setrange(Status, training.Status::Open);
            if training.findset(true) then begin
                training."Employee No" := empNo;
                training.Validate("Employee No");
                //training."Portal Request" := true;           
                training."Training Need" := trainingNeed;
                training.Validate("Training Need");
                training."Request Date" := Today;
                training.Status := training.Status::Open;
                if training.Modify(true) then begin
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('DocNo', training."Request No.");
                end else begin
                    Error('Sorry, an error occurred while modifying your request. Kindly try agaun');
                end;
            end else begin
                Error('Sorry, the requisition does not belong to you or is not open. Kindly contact the administrator.');
            end;
        end;



    end;



    [ServiceEnabled]
    procedure FnGetCalendarDays(startDate: Date; endDate: Date; perc: Decimal) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetCalendarDays(startDate, endDate, perc) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure GetCalendarDays(startDate: Date; endDate: Date; perc: Decimal)
    var
        data: Text;
        currDate: Text;
        dateName: Text;
        calendar: Record Date;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        ResourcesSetup: Record "Resources Setup";
        CompInfo: Record "Company Information";
        CustomCalendarChange: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit Microsoft.Foundation.Calendar."Calendar Management";
        hoursPerDay: Decimal;
        JsArray: JsonArray;
        DateJsObject: JsonObject;
        daysCount: Integer;

    begin

        ResourcesSetup.Get();
        // ResourcesSetup.TestField("Daily Workhours");
        CompInfo.Get();
        CalendarMgmt.SetSource(CompInfo, CustomCalendarChange);

        calendar.SetRange("Period Type", Calendar."Period Type"::Date);
        calendar.SetRange("Period Start", startDate, endDate);
        if calendar.findset(true) then begin
            Clear(JsObject);
            Clear(JsArray);
            daysCount := 0;
            repeat
                daysCount := daysCount + 1;
                hoursPerDay := 0;
                currDate := Format(Calendar."Period Start");
                dateName := TimeSheetMgt.FormatDate(Calendar."Period Start", 1);
                if CalendarMgmt.IsNonworkingDay(Calendar."Period Start", CustomCalendarChange) then
                    hoursPerDay := 0
                else
                    Clear(DateJsObject);
                DateJsObject.Add('currentDate', currDate);
                DateJsObject.Add('dateName', dateName);
                DateJsObject.Add('hoursPerDay', Format(hoursPerDay));
                if (daysCount < 6) then begin
                    // Add the date JSON object to the JSON array
                    JsArray.Add(DateJsObject);

                end;





            until calendar.Next = 0;

            // Add the JSON array to the main JSON object
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('CalendarDays', JsArray);
        end;


    end;

    [ServiceEnabled]
    procedure HandleTimeEntryRequest(jsonText: Text) RtnV: Text
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        ResourceNo: Text;
        DocNo: Text;
        ProjectNo: Text;
        TaskNo: Text;
        CauseofAbsence: Text;
        Type: Integer;
        WorkHourToken: JsonToken;
        WorkHoursArray: JsonArray;
        WorkHourText: Text;
        WorkHour: Integer;
        WorkHoursList: List of [Integer];
        i: Integer;
        IsInteger: Boolean;
    begin
        // Parse JSON text into JsonObject
        JsonObject.ReadFrom(jsonText);

        // Extract data from JSON object
        JsonObject.Get('resourceNo', JsonToken); // Use JsonToken to fetch values
        ResourceNo := JsonToken.AsValue().AsText();

        JsonObject.Get('docNo', JsonToken);
        DocNo := JsonToken.AsValue().AsText();

        JsonObject.Get('projectNo', JsonToken);
        ProjectNo := JsonToken.AsValue().AsText();

        JsonObject.Get('taskNo', JsonToken);
        TaskNo := JsonToken.AsValue().AsText();

        JsonObject.Get('causeofAbsence', JsonToken);
        CauseofAbsence := JsonToken.AsValue().AsText();

        JsonObject.Get('type', JsonToken);
        Type := JsonToken.AsValue().AsInteger();

        // Get the JSON array directly
        if JsonObject.Get('workHoursJson', JsonToken) then begin
            WorkHoursArray := JsonToken.AsArray(); // Convert JsonToken to JsonArray
            Clear(WorkHoursList);

            for i := 0 to WorkHoursArray.Count() - 1 do begin
                if WorkHoursArray.Get(i, JsonToken) then // Retrieve the value and store it in JsonToken
                begin
                    WorkHour := JsonToken.AsValue().AsInteger(); // Access element and convert directly
                    WorkHoursList.Add(WorkHour);
                end
                else begin
                    // Handle the case where retrieval fails (e.g., index out of bounds)                   
                    Message('Error: Unable to retrieve work hour at index %1.', i);
                end;
            end;

            // Process the extracted data (e.g., log values)
            Message('ResourceNo: %1, DocNo: %2, ProjectNo: %3, TaskNo: %4', ResourceNo, DocNo, ProjectNo, TaskNo);

            foreach WorkHour in WorkHoursList do begin
                Message('WorkHour: %1', WorkHour);
            end;
        end
        else begin
            // Handle case where 'workHoursJson' key is not found or is not an array
            Message('Error: Invalid or missing workHoursJson array in JSON payload.');
        end;

        Clear(JsObject);
        CLEARLASTERROR();
        if not fnPopulateTimeSheetLinesJob28(resourceNo, docNo, projectNo, taskNo, causeofAbsence, type, WorkHoursList) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);


    end;



    [ServiceEnabled]
    procedure FnCreateTimesheetLine(docNo: Code[30]; resourceNo: Code[30]; projectNo: Code[20]; taskNo: Code[20]; workHoursJson: Text) RtnV: Text;
    var
        JsObject: JsonObject;
        JsArray: JsonArray;
        WorkHours: List of [Integer];
        JsonValue: JsonValue;
        JsonToken: JsonToken; // Use JsonToken for general JSON value
        i: Integer;
    begin

        Clear(JsObject);
        Clear(JsArray);
        Clear(WorkHours);
        CLEARLASTERROR();


        // Parse the JSON string to the JsonObject
        //       if not JsObject.ReadFrom(workHoursJson) then
        //           Error('Invalid JSON format.');
        //
        //       // Extract the workHours array from the JsonObject
        //       if JsObject.Get('workHoursJson', JsonToken) then begin
        //           if JsonToken.IsArray() then begin
        //               JsArray := JsonToken.AsArray();
        //               for i := 0 to JsArray.Count() - 1 do begin
        //                   JsArray.Get(i, JsonToken);
        //                   // if JsonToken.IsInteger() then begin
        //                   JsonValue := JsonToken.AsValue();
        //                   WorkHours.Add(JsonValue.AsInteger());
        //                   //  end else
        //                   //      Error('Invalid data type in workHours array. Expected integers.');
        //               end;
        //           end else
        //               Error('workHours is not an array.');
        //       end else
        //           Error('workHours array not found in JSON.');

        // Parse the JSON array string to the JsonArray
        if not JsArray.ReadFrom(workHoursJson) then
            Error('Invalid JSON format.');

        // Process the workHours array
        for i := 0 to JsArray.Count() - 1 do begin
            JsArray.Get(i, JsonToken);
            JsonValue := JsonToken.AsValue();
            WorkHours.Add(JsonValue.AsInteger());

        end;

        if not PopulateTimeSheetLines(resourceNo, docNo, projectNo, taskNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [ServiceEnabled]
    procedure FnPopulateTimeSheetLines(resourceNo: Code[30]; docNo: Code[30]; projectNo: Code[20]; taskNo: Code[20]; workHours: array[7] of Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        //  if not PopulateTimeSheetLines(resourceNo, docNo, projectNo, taskNo, workHours) then begin
        JsObject.Add('Error', 'TRUE');
        JsObject.Add('Error_Message', GETLASTERRORTEXT());
        //  end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure PopulateTimeSheetLines(resourceNo: Code[30]; docNo: Code[30]; projectNo: Code[20]; taskNo: Code[20]);
    var
        timesheetHeader: Record "Time Sheet Header";
        timeSheetLine: Record "Time Sheet Line";
        timeSheetLineDetail: Record "Time Sheet Detail";
        myDay: Integer;
        myHours: Integer;
        myTimesheetLines: Integer;
        myDate: Date;
    begin
        myTimesheetLines := 1;
        timesheetHeader.Reset();
        timesheetHeader.setrange("No.", docNo);
        timesheetHeader.setrange("Resource No.", resourceNo);
        if timesheetHeader.findset(true) then begin
            // check whether there already exists a timesheet line and update myTimeSheetLines counter
            timeSheetLine.reset();
            timeSheetLine.setrange("Time Sheet No.", docNo);
            if timeSheetLine.findset(true) then
                myTimesheetLines += timeSheetLine.Count;
            timeSheetLine.Init;
            timeSheetLine."Time Sheet No." := docNo;
            timeSheetLine.Type := timeSheetLine.Type::Job;
            timeSheetLine."Line No." := myTimesheetLines * 10000;
            timeSheetLine."Job No." := projectNo;
            timeSheetLine.Validate("Job No.");
            timeSheetLine."Job Task No." := taskNo;
            timeSheetLine.Validate("Job Task No.");
            timeSheetLine."Work Type Code" := '';
            timeSheetLine.Status := timeSheetLine.Status::Open;
            myDate := timesheetHeader."Starting Date";

            if timeSheetLine.insert(true) then begin
                // for myHours := 1 to 7 do begin
                //
                //     timeSheetLineDetail.Init;
                //     timeSheetLineDetail."Time Sheet No." := docNo;
                //     timeSheetLineDetail."Time Sheet Line No." := timeSheetLine."Line No.";
                //     timeSheetLineDetail.Date := myDate;
                //     timeSheetLineDetail.Quantity := workHours[myHours];
                //     timeSheetLineDetail.Type := timeSheetLineDetail.Type::Resource;
                //     myDate += 1;
                //     timeSheetLineDetail.insert(true);
                //
                // end;

                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', docNo);
                JsObject.Add('Message', 'Your Time sheet line was added successfully');

            end else begin
                Error('Sorry, there was an error creating your timesheet line. Kindly try again. Contact the administrator if this error persists');
            end;
        end else begin
            Error('Sorry, you seem not to be the owner of the time sheet. Contact the administrator if this is not the case');
        end;

    end;

    [TryFunction]
    procedure fnPopulateTimeSheetLinesJob28(resourceNo: Code[30]; docNo: Code[30]; job: Code[30]; jobTask: Code[30]; causeofAbsence: Code[30]; type: Integer; workHours: List of [Integer]);
    var
        tbl_timesheetHeader: Record "Time Sheet Header";
        tbl_timeSheetLine: Record "Time Sheet Line";
        tbl_timeSheetLineDetail: Record "Time Sheet Detail";
        myDay: Integer;
        myHours: Integer;
        myTimesheetLines: Integer;
        myDate: Date;
    begin
        myTimesheetLines := 1;
        tbl_timesheetHeader.Reset();
        tbl_timesheetHeader.setrange("No.", docNo);
        tbl_timesheetHeader.setrange("Resource No.", resourceNo);
        if tbl_timesheetHeader.findset(true) then begin
            //tbl_timesheetHeader."Open Exists" := true;
            // check whether there already exists a timesheet line and update myTimeSheetLines counter
            tbl_timeSheetLine.reset();
            tbl_timeSheetLine.setrange("Time Sheet No.", docNo);
            if tbl_timeSheetLine.findset(true) then
                myTimesheetLines += tbl_timeSheetLine.Count;
            tbl_timeSheetLine.Init;
            tbl_timeSheetLine."Time Sheet No." := docNo;
            // tbl_timeSheetLine.Type := tbl_timeSheetLine.Type::Job;
            tbl_timeSheetLine.Type := type;
            tbl_timeSheetLine."Line No." := myTimesheetLines * 10000;
            tbl_timeSheetLine."Job No." := job;
            tbl_timeSheetLine.Validate("Job No.");
            tbl_timeSheetLine."Job Task No." := jobTask;
            tbl_timeSheetLine.Validate("Job Task No.");
            tbl_timeSheetLine."Cause of Absence Code" := causeofAbsence;
            tbl_timeSheetLine.Validate("Cause of Absence Code");
            tbl_timeSheetLine.Status := tbl_timeSheetLine.Status::Open;
            // tbl_timeSheetLine."Distribution Percentage" := percDistribution;
            // tbl_timeSheetLine."Work Type Code" := workType;         
            myDate := tbl_timesheetHeader."Starting Date";

            if tbl_timeSheetLine.insert(true) then begin
                // tbl_timeSheetLine.Validate("Job No.");
                // tbl_timeSheetLine.Validate("Job Task No.");
                if tbl_timeSheetLine.Modify(true) then begin

                end;

                for myHours := 1 to 5 do begin

                    tbl_timeSheetLineDetail.Init;
                    tbl_timeSheetLineDetail."Time Sheet No." := docNo;
                    tbl_timeSheetLineDetail."Time Sheet Line No." := tbl_timeSheetLine."Line No.";
                    tbl_timeSheetLineDetail.Date := myDate;
                    tbl_timeSheetLineDetail.Quantity := workHours.Get(myHours);
                    // tbl_timeSheetLineDetail.Type := tbl_timeSheetLineDetail.Type::Resource;
                    //  tbl_timeSheetLineDetail.Type := type;
                    myDate += 1;
                    tbl_timeSheetLineDetail.insert(true);
                end;

                tbl_timeSheetLine.reset();
                tbl_timeSheetLine.setrange("Time Sheet No.", docNo);
                if tbl_timeSheetLine.findset(true) then begin
                    repeat
                        if tbl_timeSheetLine.Status = tbl_timeSheetLine.Status::Open then begin
                            tbl_timeSheetLine.UpdateApproverID();
                            tbl_timeSheetLine.Status := tbl_timeSheetLine.Status::Submitted;
                            if tbl_timeSheetLine.Modify(true) then begin

                            end;

                        end;

                    until tbl_timeSheetLine.Next = 0;

                end;

                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', docNo);
                JsObject.Add('Message', 'Your Time sheet line was added successfully');

            end else begin
                Error('Sorry, there was an error creating your timesheet line. Kindly try again. Contact the administrator if this error persists');
            end;
        end else begin
            Error('Sorry, you seem not to be the owner of the time sheet. Contact the administrator if this is not the case');
        end;

    end;

    [TryFunction]
    internal procedure SubmitTimesheetLineApproval(var TimeSheetLine: Record "Time Sheet Line")
    var
        BaseImage: Text;
    begin
        TimeSheetApprovalMgt.Submit(TimeSheetLine);

    end;

    [ServiceEnabled]
    procedure FnDeleteTimesheetLine(docNo: Code[20]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteTimesheetLine(docNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure DeleteTimesheetLine(docNo: Code[20]; lineNo: Integer)
    var
        timeSheetLines: Record "Time Sheet Line";

    begin

        timeSheetLines.Reset();
        timeSheetLines.setrange("Time Sheet No.", docNo);
        timeSheetLines.setrange("Line No.", lineNo);
        if timeSheetLines.findfirst() then begin
            if timeSheetLines.Status = timeSheetLines.Status::Approved then
                Error('Sorry, The time sheet line is already approved and cannot be deleted.');
            if timeSheetLines.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('DocNo', timeSheetLines."Time Sheet No.");
            end else begin
                Error('Sorry, an error occurred while processing your request. Kindly try again.');
            end;
        end else begin
            Error('Sorry, you could not find the time sheet line. Kindly contact the administrator if this error persists.');
        end;

    end;



    [ServiceEnabled]
    procedure fnGetPayments(salaryNumber: Code[30]; employeeNumber: Code[30]; documentType: Text; status: Text) data: Text
    var
        tbl_payments: Record Payments;
    begin

        if documentType = 'Petty Cash Surrender' then begin
            tbl_payments.Reset();
            tbl_payments.SetRange("Account No.", employeeNumber);
            tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Petty Cash Surrender");
            tbl_payments.SetRange(Status, tbl_payments.Status::Released);
            if tbl_payments.FindSet(true) then begin
                repeat
                    data := data + tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                    Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' + Format(tbl_payments.Posted) + '*' +
                     Format(tbl_payments."Total Amount") + '::::';
                until tbl_payments.Next = 0;
            end;
            exit(data);

        end;
        if documentType = 'Staff Claim' then begin
            tbl_payments.Reset();
            tbl_payments.SetRange("Account No.", employeeNumber);
            tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Staff Claim");
            if tbl_payments.FindSet(true) then begin
                repeat
                    data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                     Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' + tbl_payments."Payment Narration" + '::::';
                until tbl_payments.Next = 0;
            end;
            exit(data);

        end;
        if documentType = 'Imprest' then begin
            tbl_payments.Reset();
            tbl_payments.SetRange("Account No.", employeeNumber);
            tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::Imprest);
            if tbl_payments.FindSet(true) then begin
                repeat
                    data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                     Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' +
                     Format(tbl_payments.Posted) + '*' + Format(tbl_payments."Imprest Amount") + '*' + tbl_payments.Payee + '*' +
                      Format(tbl_payments.Surrendered) + '*' + Format(tbl_payments."Payment Narration") + '::::';
                until tbl_payments.Next = 0;
            end;
            exit(data);

        end;


        if documentType = 'Surrender' then begin
            tbl_payments.Reset();
            tbl_payments.SetRange("Account No.", employeeNumber);
            tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Imprest Surrender");
            if tbl_payments.FindSet(true) then begin
                repeat
                    tbl_payments.CalcFields("Imprest Amount", "Actual Amount Spent");
                    data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                     Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' +
                     Format(tbl_payments.Posted) + '*' + tbl_payments.Payee + '*' + Format(tbl_payments."Imprest Amount") + '*' +
                     Format(tbl_payments."Imprest Issue Doc. No") + '*' + Format(tbl_payments."Payment Narration") + '*' + Format(tbl_payments."Actual Amount Spent") + '::::';
                until tbl_payments.Next = 0;
            end;
            exit(data);

        end;


    end;

    procedure addFileLinks(recordType: Text[100]; recordNo: Code[50]; filename: Text; fileLink: Text; extensionType: Text) status: Text
    var
        tbl_purchaseHeader: Record "Purchase Header";
        tbl_documentAttachments: Record "Document Attachment";
    begin
        if recordType = 'Purchase Requisition' then begin
            status := fnConvertFile(fileLink, extensionType, 38, filename, recordNo, 1);
        end else
            if recordType = 'Imprest Surrender' then begin
                status := fnConvertFile(fileLink, extensionType, 57000, filename, recordNo, 2);

            end else
                if recordType = 'Leave' then begin
                    status := fnConvertFile(fileLink, extensionType, 69205, filename, recordNo, 3);

                end else
                    if recordType = 'Imprest Requisition' then begin
                        status := fnConvertFile(fileLink, extensionType, 57000, filename, recordNo, 3);
                    end else
                        if recordType = 'Claim' then begin
                            status := fnConvertFile(fileLink, extensionType, 57000, filename, recordNo, 3);
                        end
                        else
                            if recordType = 'Store Requisition' then begin
                                status := fnConvertFile(fileLink, extensionType, 38, filename, recordNo, 11);
                            end
    end;

    procedure fnConvertFile(fileLink: Text; extensionType: Text; tableId: Integer; fileName: Text; recordNo: Code[30]; documentType: Integer) status: Text
    var
        tbl_documentAttachments: Record "Document Attachment";
        importFile: File;
        fileInstream: InStream;
        fileId: Guid;

    begin
        tbl_documentAttachments.Reset();
        tbl_documentAttachments.Init();
        tbl_documentAttachments."Table ID" := tableId;
        tbl_documentAttachments."File Name" := fileName;
        if documentType = 1 then begin
            tbl_documentAttachments."Document Type" := tbl_documentAttachments."Document Type"::Invoice;
        end
        else if documentType = 11 then begin
            tbl_documentAttachments."Document Type" := tbl_documentAttachments."Document Type"::Invoice;
        end;
        //  else if documentType = 2 then begin
        //                 tbl_documentAttachments."Document Type" := PurchaseHeader."Document Type"::"Purchase Requisition"

        // end else if documentType = 3 then begin
        //                 tbl_documentAttachments."Document Type" := PurchaseHeader."Document Type"::"Purchase Requisition";

        // end
        tbl_documentAttachments."Line No." := 10000;
        tbl_documentAttachments."No." := recordNo;
        tbl_documentAttachments."File Extension" := extensionType;
        if (extensionType.ToLower() = 'pdf') then begin
            tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::PDF;
        end else
            if (extensionType.ToLower() = 'docx') then begin
                tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Word;
            end
            else
                if (extensionType.ToLower() = 'xlsx') then begin
                    tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Excel;
                end else
                    if ((extensionType.ToLower() = 'png') OR (extensionType.ToLower() = 'jpeg') OR (extensionType.ToLower() = 'jpg')) then begin
                        tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Image;
                    end;
        //  importFile.Open(fileLink);
        //  importFile.CreateInstream(fileInstream);
        fileId := tbl_documentAttachments."Document Reference ID".ImportStream(fileInstream, fileName);
        if tbl_documentAttachments.Insert(true) then begin
            status := 'success*The document was successfully attached';
        end else begin
            status := 'error*An error occured during the process of creating a document link. kindly contact the administrator if this error persists';
        end;
        // importFile.Close;

    end;

    procedure fnConvertFile1(fileContent: Text; extensionType: Text; tableId: Integer; fileName: Text; recordNo: Code[30]; documentType: Integer) status: Text
    var
        tbl_documentAttachments: Record "Document Attachment";
        fileInstream: InStream;
        fileId: Guid;
        TempBlob: Codeunit "Temp Blob";
    begin
        tbl_documentAttachments.Reset();
        tbl_documentAttachments.Init();
        tbl_documentAttachments."Table ID" := tableId;
        tbl_documentAttachments."File Name" := fileName;
        if documentType = 1 then begin
            tbl_documentAttachments."Document Type" := tbl_documentAttachments."Document Type"::Invoice;
        end else if documentType = 11 then begin
            tbl_documentAttachments."Document Type" := tbl_documentAttachments."Document Type"::Invoice;
        end;

        tbl_documentAttachments."Line No." := 10000;
        tbl_documentAttachments."No." := recordNo;
        tbl_documentAttachments."File Extension" := extensionType;
        if extensionType.ToLower() = 'pdf' then begin
            tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::PDF;
        end else if extensionType.ToLower() = 'docx' then begin
            tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Word;
        end else if extensionType.ToLower() = 'xlsx' then begin
            tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Excel;
        end else if (extensionType.ToLower() = 'png') or (extensionType.ToLower() = 'jpeg') or (extensionType.ToLower() = 'jpg') then begin
            tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Image;
        end;

        // Convert the file content (base64 string) into a stream
        // if TempBlob.FromBase64String(fileContent) then begin
        //     TempBlob.CreateInStream(fileInstream);
        //     fileId := tbl_documentAttachments."Document Reference ID".ImportStream(fileInstream, fileName);
        //     if tbl_documentAttachments.Insert(true) then begin
        //         status := 'success*The document was successfully attached';
        //     end else begin
        //         status := 'error*An error occurred during the process of creating a document link. Kindly contact the administrator if this error persists';
        //     end;
        // end else begin
        //     status := 'error*Unable to convert the file content from the base64 string';
        // end;
    end;




    // doing this because some documents may not exist in a folder, for example,the documents attached directly from Business central. 
    // process --> Export the file from the database and save the document in the server and then read the file from the server.
    procedure fnDownloadFile(fileName: Text; recordNo: Code[30]) status: Text
    var
        tbl_documentAttachments: Record "Document Attachment";
        exportFile: File;
        fileOutstream: OutStream;

    begin
        tbl_documentAttachments.Reset();
        tbl_documentAttachments.SetRange("No.", recordNo);
        tbl_documentAttachments.Setrange("File Name", fileName);
        if tbl_documentAttachments.findset then begin
            //  exportFile.Create(DOWNLOADFILEPATH + tbl_documentAttachments."File Name" + '.' + Format(tbl_documentAttachments."File Extension"));
            //   exportFile.CreateOUTSTREAM(fileOutstream);
            //   exportFile.Close();
            //   status := 'success*' + DOWNLOADFILEPATH + tbl_documentAttachments."File Name" + '.' + Format(tbl_documentAttachments."File Extension");
        end;
    end;
    // delete document
    procedure deleteFile(fileName: Text; recordNo: Code[30])
    var
        tbl_documentAttachments: Record "Document Attachment";

    begin
        tbl_documentAttachments.Reset();
        tbl_documentAttachments.SetRange("No.", recordNo);
        tbl_documentAttachments.Setrange("File Name", fileName);
        if tbl_documentAttachments.findset then begin
            tbl_documentAttachments.Delete(true);
        end;
    end;

    [ServiceEnabled]
    procedure FnSendLeaveApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SendLeaveApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    [TryFunction]
    procedure SendLeaveApproval(docNo: Code[30])
    var
        leaveApplications: Record "Leave Application";
        VarVariant: Variant;

    begin
        leaveApplications.Reset();
        leaveApplications.setrange("Application No", docNo);
        if leaveApplications.FindFirst() then begin
            leaveApplications.TestField("Leave Period");
            leaveApplications.TestField("Days Applied");
            leaveApplications.TestField("Start Date");
            leaveApplications.TestField("End Date");
            leaveApplications.TestField("Leave Code");

            VarVariant := leaveApplications;
            //Send reliever app
            HRMgnt.SendLeaveRelieverNotice(leaveApplications."Application No");
            //send approval
            If ApprovalMgt.CheckLeaveRecallWorkflowEnabled(VarVariant) then
                ApprovalMgt.OnSendLeaveRequestApproval(VarVariant);

            UpdateApprovalEntries(DocNo, leaveApplications."User ID");
            JsObject.Add('Error', 'FALSE');

        end else begin
            Error('Sorry, Your leave application could not be found. Kindly contact the administrator');
        end;
    end;

    [ServiceEnabled]
    procedure FnCancelLeaveApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelLeaveApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    [TryFunction]
    procedure CancelLeaveApproval(DocNo: Code[50])
    var
        leaveApplications: Record "Leave Application";
        VarVariant: Variant;
    begin
        leaveApplications.Reset();
        leaveApplications.setrange("Application No", docNo);
        if leaveApplications.FindFirst() then begin
            //leaveApplications.Status := leaveApplications.Status::"Open";
            VarVariant := leaveApplications;
            ApprovalMgt.OnCancelLeaveRequestApproval(VarVariant);
            JsObject.Add('Error', 'FALSE');
        end
    end;

    [ServiceEnabled]
    procedure FnSendTimesheetApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SendTimesheetApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    [TryFunction]
    procedure SendTimesheetApproval(timesheetNo: Code[30])
    var
        tbl_TimeSheetLine: Record "Time Sheet Line";
        timeSheetApprovalMgmt: Codeunit "Time Sheet Approval Management";
        timesheetHeader: Record "Time Sheet Header";
        VarVariant: Variant;

    begin
        timesheetHeader.Reset();
        timesheetHeader.setrange("No.", timesheetNo);
        if timesheetHeader.FindFirst() then begin
            // timesheetHeader.status
            VarVariant := timesheetHeader;
            // timesheetHeader."Submitted Exists" := true;
            // timesheetHeader.Validate("Submitted Exists");
            if timesheetHeader.Modify(true) then begin
                //  If ApprovalMgt.CheckApprovalsWorkflowEnabled(VarVariant) then
                //      CustomApprovals.OnSendDocForApproval(VarVariant);
                JsObject.Add('Error', 'FALSE');
            end;

        end else begin
            Error('Sorry, Your timesheet could not be found. Kindly contact the administrator');
        end;
    end;

    [ServiceEnabled]
    procedure FnSendPurchaseApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SendPurchaseApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SendPurchaseApproval(DocNo: Code[50])
    begin
        CashManagementSetup.Get;
        GeneralLedgerSetup.Get;

        purchasesRec.Reset;
        purchasesRec.SetRange("No.", DocNo);
        if purchasesRec.FindFirst then begin
            //TestFields
            purchasesRec.TestField("Reason Description");
            Committment.CheckPurchReqCommittment(purchasesRec);
            Committment.PurchReqCommittment(purchasesRec, ErrorMsg);
            IF ErrorMsg <> '' THEN
                ERROR(ErrorMsg);

            if ApprovalMgt.CheckReqWorkflowEnabled(purchasesRec) then
                ApprovalMgt.OnSendReqRequestforApproval(purchasesRec);

            Commit;
        end;

        JsObject.Add('Error', 'FALSE');
    end;


    [ServiceEnabled]
    procedure FnCancelPurchaseApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelPurchaseApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure CancelPurchaseApproval(DocNo: Code[50])
    begin
        purchasesRec.Reset;
        purchasesRec.SetRange("No.", DocNo);
        if purchasesRec.FindFirst then begin

            ApprovalMgt.OnCancelReqApprovalRequest(purchasesRec);
            JsObject.Add('Error', 'FALSE');
        end;

    end;

    [ServiceEnabled]
    procedure FnSendTrainingApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SendTrainingApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SendTrainingApproval(DocNo: Code[50])
    begin
        CashManagementSetup.Get;
        GeneralLedgerSetup.Get;

        trainingRec.Reset;
        trainingRec.SetRange("Request No.", DocNo);
        if trainingRec.FindFirst then begin


            if ApprovalMgt.CheckTrainingRequestWorkflowEnabled(trainingRec) then
                ApprovalMgt.OnSendTrainingRequestforApproval(trainingRec);

            Commit;
        end;

        JsObject.Add('Error', 'FALSE');
    end;


    [ServiceEnabled]
    procedure FnCancelTrainingApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelTrainingApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure CancelTrainingApproval(DocNo: Code[50])
    begin
        trainingRec.Reset;
        trainingRec.SetRange("Request No.", DocNo);
        if trainingRec.FindFirst then begin

            ApprovalMgt.OnCancelTrainingRequestApproval(trainingRec);
            JsObject.Add('Error', 'FALSE');
        end;

    end;



    [ServiceEnabled]
    procedure FnSendPaymentsApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SendPaymentsApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure SendPaymentsApproval(DocNo: Code[50])
    begin
        CashManagementSetup.Get;
        GeneralLedgerSetup.Get;

        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        if PaymentsRec.FindFirst then begin
            //TestFields
            case PaymentsRec."Payment Type" of
                PaymentsRec."Payment Type"::"Bank Transfer":
                    begin
                        PaymentsRec.TestField("Receiving Bank Amount");
                        PaymentsRec.TestField("Source Bank Amount");
                        PaymentsRec.TestField("Source Bank");
                        PaymentsRec.TestField("Payment Narration");
                        PaymentsRec.TestField("Account No.");
                        PaymentsRec.TestField(Date);

                        if PaymentsRec."Receiving Amount LCY" <> PaymentsRec."Source Amount LCY" then
                            Error('Please make sure both Receiving and Source Amounts are the same');
                    end;

                PaymentsRec."Payment Type"::Imprest:
                    begin
                        PaymentsRec.CalcFields("Imprest Amount");
                        if PaymentsRec."Imprest Amount" <= 0 then
                            Error('Imprest Amount can not be less than or equal to 0');

                        PaymentsRec.TestField("Payment Narration");

                        Committment.CheckImprestCommittment(PaymentsRec);
                        Committment.ImprestCommittment(PaymentsRec, ErrorMsg);
                        if ErrorMsg <> '' then
                            Error(ErrorMsg);
                        Commit;
                    end;

                PaymentsRec."Payment Type"::"Imprest Surrender":
                    begin
                        PaymentsRec.TestField("Surrender Date");
                    end;

                PaymentsRec."Payment Type"::"Payment Voucher":
                    begin
                        PaymentsRec.TestField("Paying Bank Account");
                        PaymentsRec.TestField("Shortcut Dimension 1 Code");
                        PaymentsRec.TestField("Shortcut Dimension 2 Code");
                        PaymentsRec.TestField(Payee);
                        PaymentsRec.TestField("Payment Narration");

                        PLines.Reset;
                        PLines.SetRange(No, PaymentsRec."No.");
                        if PLines.Find('-') then begin
                            repeat
                                if PLines."Account No" = '' then
                                    Error('Account No. Field is Blank. Please Fill the Line No. %1 with amount %2.', PLines."Line No", PLines.Amount);
                            until PLines.Next = 0;
                        end;

                        Committment.CheckPVCommittment(PaymentsRec);
                        Committment.PVCommittment(PaymentsRec, ErrorMsg);
                        if ErrorMsg <> '' then
                            Error(ErrorMsg);
                    end;

                PaymentsRec."Payment Type"::"Petty Cash":
                    begin
                        PaymentsRec.CalcFields("Petty Cash Amount");
                        if PaymentsRec."Petty Cash Amount" <= 0 then
                            Error('Petty Cash Amount can not be less than or equal to 0');

                        if PaymentsRec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then
                            Error('Petty Cash amount can not be greater than %1.%2', GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");

                        Committment.CheckPettyCashCommittment(PaymentsRec);
                        Committment.PettyCashCommittment(PaymentsRec, ErrorMsg);
                        if ErrorMsg <> '' then
                            Error(ErrorMsg);
                    end;

                PaymentsRec."Payment Type"::"Petty Cash Surrender":
                    begin
                    end;

                PaymentsRec."Payment Type"::"Staff Claim":
                    begin
                        if PaymentsRec."Payment Narration" = '' then
                            Error('Please define the Purpose for this claim');

                        PLines.Reset;
                        PLines.SetRange(PLines.No, PaymentsRec."No.");
                        if PLines.Find('-') then begin
                            repeat
                                PLines.TestField("Expenditure Date");
                                PLines.TestField("Expenditure Description");
                                if PLines.Amount <= 0 then
                                    Error('One of your lines has an amount less than or equal to 0');
                            until PLines.Next = 0;
                        end;

                        Committment.CheckStaffClaimCommittment(PaymentsRec);
                        Committment.StaffClaimCommittment(PaymentsRec, ErrorMsg);
                        if ErrorMsg <> '' then
                            Error(ErrorMsg);
                    end;
            end;

            if ApprovalMgt.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                ApprovalMgt.OnSendPaymentsForApproval(PaymentsRec);
            UpdateApprovalEntries(DocNo, PaymentsRec."Created By");
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnCancelPaymentsApproval(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelPaymentsApproval(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure CancelPaymentsApproval(DocNo: Code[50])
    begin
        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        if PaymentsRec.FindFirst then begin
            case PaymentsRec."Payment Type" of
                PaymentsRec."Payment Type"::"Bank Transfer":
                    begin
                    end;

                PaymentsRec."Payment Type"::Imprest:
                    begin
                        Committment.CancelPaymentsCommitments(PaymentsRec);
                        ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                    end;

                PaymentsRec."Payment Type"::"Imprest Surrender":
                    begin
                    end;

            end;
            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
            JsObject.Add('Error', 'FALSE');
        end;

    end;

    procedure UpdateApprovalEntries(DocNo: Code[100]; SenderID: Code[100])
    var
        ApprovalEntryRec: Record "Approval Entry";
    begin
        //Update USERID on Approval Entries
        ApprovalEntryRec.Reset;
        ApprovalEntryRec.SetRange("Document No.", DocNo);
        ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
        if ApprovalEntryRec.Find('-') then begin
            repeat
                ApprovalEntryRec."Sender ID" := SenderID;
                ApprovalEntryRec.Modify;
            until ApprovalEntryRec.Next = 0;
        end;
    end;

    procedure fnApproveRequest(docNo: Code[20]; username: Text) data: Text
    var
        approvalEntry: Record "Approval Entry";
        approvalManagement: Codeunit "Approvals Mgmt.";
    begin
        approvalEntry.reset();
        approvalEntry.SetRange("Document No.", docNo);
        approvalEntry.Setrange("Approver ID", username);
        approvalEntry.Setrange(Status, approvalEntry.Status::Open);
        if approvalEntry.findset(true) then begin
            approvalManagement.ApproveApprovalRequests(approvalEntry);
            // check whether the record has been approved successfully
            approvalEntry.reset();
            approvalEntry.SetRange("Document No.", docNo);
            approvalEntry.Setrange("Approver ID", username);
            approvalEntry.SetRange(Status, approvalEntry.Status::Approved);
            if approvalEntry.findset(true) then begin
                data += 'success*The Record has been approved successfully';
            end else begin
                data += 'danger*Sorry, you could not approve the request. Kindly try again.'
            end;

        end else begin
            data += 'danger*Sorry, the record to be approved could not be found. You may have already approved it or you are not its approver. Kindly contact the ICT team for assistance';
        end;
        exit(data);

    end;

    [ServiceEnabled]
    procedure FnOpenPaymentsDocument(docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not OpenPaymentsDocument(docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    [TryFunction]
    procedure OpenPaymentsDocument(DocNo: Code[50])
    begin
        PaymentsRec.Reset;
        PaymentsRec.SetRange("No.", DocNo);
        PaymentsRec.SetRange(Posted, true);
        PaymentsRec.SetRange(Status, PaymentsRec.Status::Released);
        if PaymentsRec.FindSet() then begin
            PaymentsRec.Status := PaymentsRec.Status::Open;
            if PaymentsRec.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
            end
            else begin
                Error(('the document cannot be reopened'));
            end;


        end
        else begin
            Error('Oops! You can only open a document that is approved and not posted');
        end;

    end;


    [ServiceEnabled]
    procedure FnUploadAttachedDocument(docNo: Code[50]; fileName: Text; fileExt: Text; attachment: Text; tableID: Integer) returnV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not UploadAttachedDocument(docNo, fileName, fileExt, attachment, tableID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure UploadAttachedDocument(DocNo: Code[50]; FileName: Text; fileExt: Text; attachment: Text; TableID: Integer)
    var
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        tableFound: Boolean;
        DocAttachment: Record "Document Attachment";
    begin
        tableFound := false;
        if TableID = Database::Payments then begin
            PaymentsRec.RESET;
            PaymentsRec.SETRANGE("No.", DocNo);
            if PaymentsRec.FIND('-') then begin
                FromRecRef.GETTABLE(PaymentsRec);
            end;
            tableFound := true;
        end;
        if TableID = Database::"Internal Request Header" then begin
            purchasesRec.RESET;
            purchasesRec.SETRANGE("No.", DocNo);
            if purchasesRec.FIND('-') then begin
                FromRecRef.GETTABLE(purchasesRec);
            end;
            tableFound := true;
        end;


        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                Base64Convert.FromBase64(attachment, Outstr);
                TempBlob_lRec.CreateInStream(InStr, TEXTENCODING::UTF8);

                DocAttachment.Init();
                DocAttachment.Validate("File Extension", fileExt);
                DocAttachment.Validate("File Name", FileName);
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", DocNo);
                DocAttachment."Document Reference ID".ImportStream(InStr, '', FileName);
                DocAttachment.Insert(true);
                JsObject.Add('Error', 'FALSE');
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    [ServiceEnabled]
    procedure FnDeleteDocumentAttachment(docNo: Code[20]; tableID: Integer; docID: Integer) returnV: Text
    var
        DocAttachment: Record "Document Attachment";
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DropDocumentAttachment(docNo, tableID, docID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure DropDocumentAttachment(DocNo: Code[20]; TableID: Integer; DocID: Integer)
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", TableID);
        DocAttachment.SetRange("No.", DocNo);
        DocAttachment.SetRange(ID, DocID);
        if DocAttachment.Find('-') then begin
            if DocAttachment."Document Reference ID".HasValue then begin
                Clear(DocAttachment."Document Reference ID");
                DocAttachment.Modify(true);
            end;
            DocAttachment.Delete(true);
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnGetDocumentAttachment(tableId: Integer; no: Code[20]; recID: Integer) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetAttachment(tableId, no, recID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    procedure GetAttachment(tableId: Integer; No: Code[20]; RecID: Integer)
    var
        TenantMedia: Record "Tenant Media";
        imageID: GUID;
        docAttachment: Record "Document Attachment";
        BaseImage: Text;
        fom: Codeunit "Format Document";
    begin
        docAttachment.Reset();
        docAttachment.SetRange("Table ID", tableId);
        docAttachment.SetRange("No.", No);
        docAttachment.SetRange(ID, RecID);
        if docAttachment.find('-') then begin
            if docAttachment."Document Reference ID".Hasvalue then begin
                imageID := docAttachment."Document Reference ID".MediaId;
                IF TenantMedia.GET(imageID) THEN BEGIN
                    TenantMedia.CALCFIELDS(Content);
                    TenantMedia.Content.CreateInstream(InStr, TEXTENCODING::UTF8);
                    BaseImage := Base64Convert.ToBase64(InStr);
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('BaseImage', BaseImage);
                END;
            end;
        end;
    end;


    var
        Employee: Record Employee;
        JsObject: JsonObject;
        NextNo: Code[20];
        TempBlob_lRec: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        DocRelease: Codeunit "Document Release";
        Committment: Codeunit Committment;
        Text001: Label 'Are you sure you want to send this record for Approval?';
        ApprovalMgt: Codeunit ApprovalMgtCuExtension;
        TimeSheetApprovalMgt: Codeunit "Time Sheet Approval Management";
        HRMgnt: Codeunit "HR Management";
        trainingRec: Record "Training Request";
        purchasesRec: Record "Internal Request Header";
        PaymentsRec: Record Payments;
        PLines: Record "Payment Lines";
        ApprovalEntry: Record "Approval Entry";
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ErrorMsg: Text;



}