report 50517 "Training Schedule"
{
    Caption = 'Training Schedule';
    DefaultLayout = RDLC;
    RDLCLayout = './Report/TrainingSchedule.rdl';
    ApplicationArea = All;
    dataset
    {
        dataitem("Training Request"; "Training Request")
        {
            DataItemTableView = where(Status = filter('Released'));
            RequestFilterFields = Designation, "Planned Start Date", "No. Of Days", "Employee No", "Cost of Training (LCY)";
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
            column(Request_No_; "Request No.")
            {

            }
            column(Request_Date; "Request Date")
            {

            }
            // column(Trustee_employee; "Trustee/employee")
            // {

            // }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Designation; Designation)
            {

            }
            column(Training_Need; "Training Need")
            {

            }
            column(Destination; Destination)
            {

            }
            column(Description; Description)
            {

            }
            column(Planned_Start_Date; "Planned Start Date")
            {

            }
            column(Planned_End_Date; "Planned End Date")
            {

            }
            column(No__Of_Days; "No. Of Days")
            {

            }
            column(Cost_of_Training__LCY_; "Cost of Training (LCY)")
            {

            }



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
        i: Integer;
        j: Integer;
        k: Integer;
        ArrayHeading: array[10000] of Text;
        ArrayValue: array[10000] of Text;
        NoOfYears: Decimal;
        MaxExperience: Decimal;
        OtherRoles: array[1000] of Text;
        Others: Text;
        CompanyInfo: Record "Company Information";



    // procedure GetPreviousEmployment(DocNo: Code[50]): Text
    // var
    //     Experience: Record "Applicant Job Experience2";
    //     OtherRoles: array[1000] of Text;
    //     Others: Text;
    // begin
    //     Experience.Reset();
    //     Experience.SetRange("Applicant No.", DocNo);
    //     Experience.SetRange("Present Employment", false);
    //     if Experience.Get(DocNo) then begin
    //         repeat
    //             i := i + 1;
    //             if (Experience."Start Date" <> 0D) and (Experience."End Date" <> 0D) then
    //                 OtherRoles[i] := Experience.Employer + ' ' + '(' + format(Date2DMY(Experience."Start Date", 3)) + format(Date2DMY(Experience."Start Date", 3)) + ')' + ' ' + Experience."Job Title";
    //         until Experience.Next = 0;

    //         for j := 1 to i do begin
    //             if j = 1 then
    //                 Others := OtherRoles[j]
    //             else
    //                 Others := Others + ' ' + OtherRoles[j];
    //         end;
    //     end;
    //     exit(Others);
    // end;

}
