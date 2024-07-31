report 50197 "Travel Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TravelRequest.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Travel Requests"; "Travel Requests")
        {
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(County; CompanyInfo.County)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Sign_Title; Signatories."Title/Position")
            {
            }
            column(Document_Type; Signatories."Document Type")
            {
            }
            column(Sign_Name; Signatories."Signing Name")
            {
            }
            column(Signature; Signatories.Signature)
            {
            }
            column(Request_No; "Travel Requests"."Request No.")
            {
            }
            column(Date; "Travel Requests"."Request Date")
            {
            }
            column(Employee_No; "Travel Requests"."Employee No.")
            {
            }
            column(Employee_Name; "Travel Requests"."Employee Name")
            {
            }
            column(Start_Date; "Travel Requests"."Trip Planned Start Date")
            {
            }
            column(End_Date; "Travel Requests"."Trip Planned End Date")
            {
            }
            column(Destination; "Travel Requests".Destination)
            {
            }
            column(No_of_Personnel; "Travel Requests"."No. of Personnel")
            {
            }
            column(Reason_for_Travel; "Travel Requests"."Reason for Travel")
            {
            }
            column(No_of_Students; "Travel Requests"."No. of Students")
            {
            }
            column(DepartmentN; "Travel Requests"."Department Name")
            {
            }
            column(Prepared_By; GetUserName(Approver[1]))
            {
            }
            column(Date_Prepared; DateApproved[1])
            {
            }
            column(Prepared_By_Signature; Users1.Signature)
            {
            }
            column(First_Approver; GetUserName(Approver[2]))
            {
            }
            column(First_Date_Approved; DateApproved[2])
            {
            }
            column(First_Approver_Signature; Users2.Signature)
            {
            }
            column(Second_Approver; GetUserName(Approver[3]))
            {
            }
            column(Second_Date_Approved; DateApproved[3])
            {
            }
            column(Second_Approver_Signature; Users3.Signature)
            {
            }
            column(Vehicle_Allocated; "Travel Requests"."Vehicle Allocated")
            {
            }
            column(Driver_Name; "Travel Requests"."Driver Name")
            {
            }
            column(Third_Approver; GetUserName(Approver[4]))
            {
            }
            column(Third_Date_Approved; DateApproved[4])
            {
            }
            trigger OnAfterGetRecord()
            begin
                Approver[1] := "Travel Requests"."User ID";
                DateApproved[1] := CreateDateTime("Travel Requests"."Request Date", "Travel Requests"."Request Time");
                ApprovalEntries.Reset;
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", 50239);
                ApprovalEntries.SetRange("Document No.", "Travel Requests"."Request No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[2] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[3] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[4] := ApprovalEntries."Last Date-Time Modified";
                        end;
                    until ApprovalEntries.Next = 0;
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
        Signatories.Reset;
        Signatories.SetRange("Document Type", Signatories."Document Type"::"Travel Request");
        if Signatories.FindFirst then begin
            Officer[1] := Signatories."Signing Name";
            OfficerTitle[1] := Signatories."Title/Position";
            Signatories.CalcFields(Signature);
        end;
        Signatories2.Reset;
        Signatories2.SetRange("Document Type", Signatories2."Document Type"::"Exam Signatory");
        if Signatories2.FindFirst then begin
            Officer[2] := Signatories2."Signing Name";
            OfficerTitle[2] := Signatories2."Title/Position";
            Signatories2.CalcFields(Signature);
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        Signatories: Record Signatories;
        Signatories2: Record Signatories;
        Officer: array[3] of Text;
        OfficerTitle: array[3] of Text;
        Approvals: Record "Approval Entry";
        i: Integer;
        Users1: Record "User Setup";
        Users2: Record "User Setup";
        Users3: Record "User Setup";
        Approver: array[10] of Code[30];
        DateApproved: array[10] of DateTime;
        ApprovalEntries: Record "Approval Entry";
        Travel: Record "Travel Requests";

    local procedure GetUserName(UserID: Code[30]): Text[100]
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
    begin
        if UserSetup.Get(UserID) then begin
            Employee.Reset;
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        end;
    end;
}
