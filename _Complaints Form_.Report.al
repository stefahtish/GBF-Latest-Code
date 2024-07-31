report 50400 "Complaints Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ComplaintsForm.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ClientInteractionHeader; "Client Interaction Header")
        {
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
            column(Client_Name; "Client Name")
            {
            }
            column(Address; Address)
            {
            }
            column(Client_Phone_No_; "Client Phone No.")
            {
            }
            column(Client_Email; "Client Email")
            {
            }
            column(Problem_Reported; ProblemNotesText)
            {
            }
            column(Hr_Comment; ResolutionNotesText)
            {
            }
            column(User_ID; GetUserName("User ID"))
            {
            }
            column(UserSignature; UserSetup1.Signature)
            {
            }
            column(UserDesignation; GetUserDesignation("User ID"))
            {
            }
            column(Datetime_Claim_Received; "Datetime Claim Received")
            {
            }
            column(Datetime_Claim_Updated; "Datetime Claim Updated")
            {
            }
            column(Datetime_Claim_Assigned; "Datetime Claim Assigned")
            {
            }
            column(Closed_By; GetUserName("Closed By"))
            {
            }
            column(ClosedBySignature; UserSetup2.Signature)
            {
            }
            column(Closed_DateTime; "Archived DateTime")
            {
            }
            column(ClosedDesignation; GetUserDesignation("Archived By"))
            {
            }
            column(Status; Status)
            {
            }
            column(User_DateTime_Received; "User DateTime Received")
            {
            }
            column(HOD; GetUserName("HR user ID"))
            {
            }
            column(HODDesignation; GetUserDesignation("HR user ID"))
            {
            }
            column(Remarks__Observation; "Remarks/ Observation")
            {
            }
            column(Notes; Notes)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Problem Reported", "Hr Comment");
                "Problem Reported".CREATEINSTREAM(Instr);
                ProblemNote.READ(Instr);
                ProblemNotesText := FORMAT(ProblemNote);
                "Hr Comment".CREATEINSTREAM(Instr);
                ResolutionNote.READ(Instr);
                ResolutionNotesText := FORMAT(ResolutionNote);
                UserSetup1.Reset();
                UserSetup1.SetRange("User ID", "User ID");
                if UserSetup1.FindFirst() then UserSetup1.CalcFields(Signature);
                UserSetup2.Reset();
                UserSetup2.SetRange("User ID", "Archived By");
                if UserSetup2.FindFirst() then UserSetup2.CalcFields(Signature);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ProblemNote: BigText;
        ProblemNotesText: Text;
        ResolutionNote: BigText;
        ResolutionNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";

    procedure GetUserName(User: Code[50]): Text
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", User);
        if UserSetup.FindFirst() then begin
            Employee.Reset();
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
        end;
    end;

    procedure GetUserDesignation(User: Code[50]): Text
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", User);
        if UserSetup.FindFirst() then begin
            Employee.Reset();
            Employee.SetRange("No.", UserSetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."Job Position Title");
        end;
    end;
}
