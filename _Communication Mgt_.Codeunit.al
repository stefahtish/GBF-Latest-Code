codeunit 50131 "Communication Mgt"
{
    trigger OnRun()
    begin
    end;
    var CompanyInfo: Record "Company Information";
    Employee: Record Employee;
    HRSetup: Record "Human Resources Setup";
    leaveApp: Record "Leave Application";
    Change: Record "Employee Change Request";
    CurrYear: Integer;
    Year: Integer;
    R: Date;
    //FileSystem: Automation BC;
    FileManagement: Codeunit "File Management";
    Emailmessage: Codeunit "Email Message";
    //SMTPSetup: Record "SMTP Mail Setup";
    SenderName: Text;
    SenderAddress: Text;
    Receipient: list of[Text];
    Subject: Text;
    FileName: Text;
    TimeNow: Text;
    RecipientCC: Text;
    Attachment: Text;
    ErrorMsg: Text;
    UserSetup: Record "User Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ICTSetup: Record "ICT Setup";
    Window: Dialog;
    TotalCount: Integer;
    Counter: Integer;
    Percentage: Integer;
    LeaveType: Record "Leave Type";
    AnnualLeave: Text;
    Assigned: Boolean;
    Month: Text;
    LineNo: Integer;
    procedure GenerateCommUsers(CommHeader: Record "Email/SMS Logging Header")
    var
        Text0001: Label 'Generate %1 User lines. Would you like to Proceed?';
        Text0002: Label 'Generate Users from which Group?';
        OptStrng: Label 'Customers,Vendors,Employees,Contacts,Members';
        Selection: Integer;
    begin
        Selection:=StrMenu(OptStrng, 0, Text0002);
        case true of Selection = 1: begin
            InsertCustomers(CommHeader."No.");
        end;
        Selection = 2: begin
            InsertVendors(CommHeader."No.");
        end;
        Selection = 3: begin
            InsertEmployees(CommHeader."No.");
        end;
        Selection = 4: begin
            InsertContact(CommHeader."No.");
        end;
        Selection = 5: begin
            InsertMembers(CommHeader."No.");
        end;
        end;
    end;
    procedure InsertEmployees(No: Code[20])
    var
        Employee: Record Employee;
        FilterEmployee: FilterPageBuilder;
        CommLines: Record "Email/SMS Logging Lines";
    begin
        Clear(FilterEmployee);
        FilterEmployee.AddTable(Employee.TableName, DATABASE::Employee);
        FilterEmployee.ADdField(Employee.TableName, Employee."Global Dimension 2 Code");
        if not FilterEmployee.RunModal then exit;
        Employee.SetView(FilterEmployee.GetView(Employee.TableName));
        if Employee.FindSet then repeat LineNo:=LineNo + 1000;
                CommLines.Init;
                CommLines."No.":=No;
                CommLines.Category:=CommLines.Category::Staff;
                CommLines."Recipient No.":=Employee."No.";
                CommLines."Line No.":=LineNo;
                CommLines."Recipient Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                CommLines."Recipient E-Mail":=Employee."E-Mail";
                CommLines."Recipient Phone No.":=Employee."Phone No.";
                CommLines.Insert;
            until Employee.Next = 0;
    end;
    procedure InsertVendors(CommNo: Code[20])
    var
        Vendor: Record Vendor;
        CommLines: Record "Email/SMS Logging Lines";
        FilterVendor: FilterPageBuilder;
    begin
        Clear(FilterVendor);
        FilterVendor.AddTable(Vendor.TableName, DATABASE::Vendor);
        FilterVendor.ADdField(Vendor.TableName, Vendor."No.");
        if not FilterVendor.RunModal then exit;
        Vendor.SetView(FilterVendor.GetView(Vendor.TableName));
        if Vendor.FindSet then repeat LineNo:=LineNo + 1000;
                CommLines.Init;
                CommLines."No.":=CommNo;
                CommLines.Category:=CommLines.Category::Vendor;
                CommLines."Recipient No.":=Vendor."No.";
                CommLines."Line No.":=LineNo;
                CommLines."Recipient Name":=Vendor.Name;
                CommLines."Recipient E-Mail":=Vendor."E-Mail";
                CommLines."Recipient Phone No.":=Vendor."Phone No.";
                CommLines.Insert;
            until Vendor.Next = 0;
    end;
    procedure InsertCustomers(CommNo: Code[20])
    var
        FilterCustomer: FilterPageBuilder;
        Customer: Record Customer;
        CommLines: Record "Email/SMS Logging Lines";
    begin
        Clear(FilterCustomer);
        FilterCustomer.AddTable(Customer.TableName, DATABASE::Customer);
        FilterCustomer.ADdField(Customer.TableName, Customer."No.");
        if not FilterCustomer.RunModal then exit;
        Customer.SetView(FilterCustomer.GetView(Customer.TableName));
        if Customer.FindSet then repeat LineNo:=LineNo + 1000;
                CommLines.Init;
                CommLines."No.":=CommNo;
                CommLines.Category:=CommLines.Category::Customer;
                CommLines."Recipient No.":=Customer."No.";
                CommLines."Line No.":=LineNo;
                CommLines."Recipient Name":=Customer.Name;
                CommLines."Recipient E-Mail":=Customer."E-Mail";
                CommLines."Recipient Phone No.":=Customer."Phone No.";
                CommLines.Insert;
            until Customer.Next = 0;
    end;
    procedure SendCorporateEmails(CommNo: Code[20])
    var
        OptStrng: Label 'SMS,E-Mail';
        CommHeader: Record "Email/SMS Logging Header";
        CommLines: Record "Email/SMS Logging Lines";
        Text0001: Label 'Do you want to send %1 to the Selected Users?';
        CommHeader2: Record "Email/SMS Logging Header";
        Instr: InStream;
        Email: Codeunit email;
        Emailmessage: Codeunit "Email Message";
        EmailBodyText: Text;
        EmailBodyBigText: BigText;
    begin
        ICTSetup.Get;
        ICTSetup.TestField("Communication E-Mail");
        CompanyInfo.Get;
        if CommHeader.Get(CommNo)then begin
            case CommHeader."Communication Type" of CommHeader."Communication Type"::"E-Mail": begin
                //Calc E-Mail Body
                CommHeader.CalcFields("E-Mail Body Text");
                CommHeader."E-Mail Body Text".CreateInStream(Instr);
                EmailBodyBigText.Read(Instr);
                EmailBodyText:=Format(EmailBodyBigText);
                CommLines.Reset;
                CommLines.SetRange("No.", CommNo);
                if CommLines.Find('-')then repeat SenderName:=CompanyInfo.Name;
                        SenderAddress:=ICTSetup."Communication E-Mail";
                        Receipient.Add(CommLines."Recipient E-Mail");
                        Subject:=CommHeader."E-Mail Subject";
                        TimeNow:=Format(Time);
                        FileName:=CommHeader.Attachment;
                        Emailmessage.Create(Receipient, Subject, '', CommHeader."HTML Formatted");
                        Emailmessage.AppendToBody(StrSubstNo(EmailBodyText));
                        Emailmessage.AddAttachment(FileName, Attachment, '');
                        email.Send(Emailmessage);
                        if ErrorMsg <> '' then begin
                            CommLines."E-Mail Sent":=false;
                            CommLines.Sent:=false;
                        end
                        else
                        begin
                            CommLines."E-Mail Sent":=true;
                            CommLines.Sent:=true;
                        end;
                        CommLines."Error Message":=ErrorMsg;
                        CommLines.Modify;
                        Commit;
                    until CommLines.Next = 0;
                //Mark Fully Sent
                CommHeader.CalcFields("Total Items", "Total Sent");
                if CommHeader."Total Items" = CommHeader."Total Sent" then begin
                    CommHeader.Status:=CommHeader.Status::Complete;
                    CommHeader.Modify;
                end;
            end;
            CommHeader."Communication Type"::SMS: begin
            end;
            CommHeader."Communication Type"::"E-Mail & SMS": begin
            end;
            end;
        end;
        CommHeader.Status:=CommHeader.Status::Complete;
        CommHeader.Modify;
    end;
    procedure InsertContact(ComNo: Code[30])
    var
        Contact: Record Contact;
        CommLine: Record "Email/SMS Logging Lines";
        FilterContact: FilterPageBuilder;
    begin
        Clear(FilterContact);
        FilterContact.AddTable(Contact.TableName, DATABASE::Contact);
        FilterContact.ADdField(Contact.TableName, Contact."No.");
        FilterContact.ADdField(Contact.TableName, Contact.Type);
        if not FilterContact.RunModal then exit;
        Contact.SetView(FilterContact.GetView(Contact.TableName));
        if Contact.FindSet then repeat LineNo:=LineNo + 1000;
                CommLine.Init;
                CommLine."No.":=ComNo;
                CommLine.Category:=CommLine.Category::Contact;
                CommLine."Recipient No.":=Contact."No.";
                CommLine."Line No.":=LineNo;
                CommLine."Recipient Name":=Contact.Name;
                CommLine."Recipient E-Mail":=Contact."E-Mail";
                CommLine."Recipient Phone No.":=Contact."Phone No.";
                CommLine.Insert;
            until Contact.Next = 0;
    end;
    procedure InsertMembers(CommNo: Code[20])
    var
        Vendor: Record Vendor;
        CommLines: Record "Email/SMS Logging Lines";
        FilterMember: FilterPageBuilder;
    begin
        Clear(FilterMember);
        FilterMember.AddTable('Members', DATABASE::Vendor);
        FilterMember.ADdField('Members', Vendor."No.");
        FilterMember.ADdField('Members', Vendor."Vendor Type", 'Member');
        FilterMember.PageCaption:='Members';
        if not FilterMember.RunModal then exit;
        Vendor.SetView(FilterMember.GetView('Members'));
        if Vendor.FindSet then repeat LineNo:=LineNo + 1000;
                CommLines.Init;
                CommLines."No.":=CommNo;
                CommLines.Category:=CommLines.Category::Vendor;
                CommLines."Recipient No.":=Vendor."No.";
                CommLines."Line No.":=LineNo;
                CommLines."Recipient Name":=Vendor.Name;
                CommLines."Recipient E-Mail":=Vendor."E-Mail";
                CommLines."Recipient Phone No.":=Vendor."Phone No.";
                CommLines.Insert;
            until Vendor.Next = 0;
    end;
    procedure ClearLines(CommHeader: Record "Email/SMS Logging Header")
    var
        CommLines: Record "Email/SMS Logging Lines";
    begin
        CommLines.Reset;
        CommLines.SetRange("No.", CommHeader."No.");
        CommLines.DeleteAll;
    end;
}
