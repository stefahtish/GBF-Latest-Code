report 50510 "Recruitment Report"
{
    Caption = 'Recruitment Report';
    DefaultLayout = RDLC;
    RDLCLayout = './RecruitmentReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Applicantjobapplied; "Applicant job applied")
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
            column(CompanyEmail; '')
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(No_; "No.")
            {
            }
            column(Application_No_; "Application No.")
            {
            }
            dataitem(Integer; Integer)
            {
                column(ArrayHeading; ArrayHeading[Integer.Number])
                {
                }
                column(ArrayValue; ArrayValue[Integer.Number])
                {
                }
                column(i; Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    Setrange(Number, 1, i);
                end;
            }
            trigger OnAfterGetRecord()
            var
                Experience: Record "Applicant Job Experience2";
                Memberships: Record "Applicant Prof Membership2";
                ApplicantEducation: Record "Applicant Job Education2";
                Applicant: Record Applicants2;
                ProfMemberships: Record "Professional Memberships Setup";
                Recruitment: Record "Recruitment Needs";
            begin
                i := 1;
                Applicant.Reset();
                Applicant.SetRange("No.", "Application No.");
                if Applicant.FindFirst() then begin
                    ArrayHeading[i] := 'First Name';
                    ArrayValue[i] := Applicant."First Name";
                    i += 1;
                    ArrayHeading[i] := 'Last Name';
                    ArrayValue[i] := Applicant."Last Name";
                    i += 1;
                end;
                ApplicantEducation.Reset();
                ApplicantEducation.SetRange("Applicant No.", "Application No.");
                ApplicantEducation.SetRange("Applicant Education level", ApplicantEducation."Applicant Education level"::"Masters Degree");
                if ApplicantEducation.FindFirst() then begin
                    ArrayHeading[i] := 'Masters';
                    ArrayValue[i] := 'Yes';
                    i += 1;
                end
                else begin
                    ArrayHeading[i] := 'Masters';
                    ArrayValue[i] := 'No';
                    i += 1;
                end;
                ApplicantEducation.Reset();
                ApplicantEducation.SetRange("Applicant No.", "Application No.");
                ApplicantEducation.SetRange("Applicant Education level", ApplicantEducation."Applicant Education level"::Doctorate);
                if ApplicantEducation.FindFirst() then begin
                    ArrayHeading[i] := 'Post-Graduate';
                    ArrayValue[i] := 'Yes';
                    i += 1;
                end
                else begin
                    ArrayHeading[i] := 'Post-Graduate';
                    ArrayValue[i] := 'No';
                    i += 1;
                end;
                ApplicantEducation.Reset();
                ApplicantEducation.SetRange("Applicant No.", "Application No.");
                ApplicantEducation.SetRange("Applicant Education level", ApplicantEducation."Applicant Education level"::"Higher/Post Graduate Diploma");
                if ApplicantEducation.FindFirst() then begin
                    ArrayHeading[i] := 'Higher/Post Graduate Diploma';
                    ArrayValue[i] := 'Yes';
                    i += 1;
                end
                else begin
                    ArrayHeading[i] := 'Higher/Post Graduate Diploma';
                    ArrayValue[i] := 'No';
                    i += 1;
                end;
                ProfMemberships.Reset();
                ProfMemberships.SetFilter(Name, '<>%1', '');
                if ProfMemberships.Find('-') then
                    repeat
                        Memberships.Reset();
                        Memberships.SetRange("Applicant No.", "Application No.");
                        Memberships.SetRange("Professional Body", ProfMemberships.Name);
                        if Memberships.FindFirst() then begin
                            ArrayHeading[i] := (ProfMemberships.Description);
                            ArrayValue[i] := 'Yes';
                            i += 1;
                        end
                        else begin
                            ArrayHeading[i] := ProfMemberships.Description;
                            ArrayValue[i] := 'No';
                            i += 1;
                        end;
                    until ProfMemberships.Next() = 0;
                Experience.Reset();
                Experience.SetRange("Applicant No.", "Application No.");
                Experience.SetRange("Present Employment", true);
                if Experience.FindFirst() then begin
                    ArrayHeading[i] := 'Current Employer';
                    ArrayValue[i] := Experience.Employer;
                    i += 1;
                    ArrayHeading[i] := 'Current Role';
                    ArrayValue[i] := Experience."Job Title";
                    i += 1;
                end
                else begin
                    ArrayHeading[i] := 'Current Employer';
                    ArrayValue[i] := ' ';
                    i += 1;
                    ArrayHeading[i] := 'Current Role';
                    ArrayValue[i] := ' ';
                    i += 1;
                end;
                Clear(OtherRoles);
                Clear(Others);
                k := 0;
                j := 0;
                Experience.Reset();
                Experience.SetRange("Applicant No.", "Application No.");
                Experience.SetRange("Present Employment", false);
                if Experience.Find('-') then begin
                    repeat
                        k := k + 1;
                        if (Experience."Start Date" <> 0D) and (Experience."End Date" <> 0D) then OtherRoles[k] := Experience.Employer + ' - ' + Experience."Job Title" + '-' + '(' + format(Experience."Start Date", 0, '<Month Text> <Year4>') + ' to ' + format(Experience."End Date", 0, '<Month Text> <Year4>') + ')';
                    until Experience.Next = 0;
                    for j := 1 to k do begin
                        if j = 1 then
                            Others := OtherRoles[j]
                        else
                            Others := Others + ' ' + OtherRoles[j];
                    end;
                    ArrayHeading[i] := 'Previous Employers';
                    ArrayValue[i] := Others;
                    i += 1;
                end;
                Recruitment.Reset();
                Recruitment.SetRange("No.", "Need Code");
                if Recruitment.FindFirst() then begin
                    MaxExperience := Recruitment."Minimum years of experience";
                    if Recruitment."Experience industry" <> '' then begin
                        Experience.Reset();
                        Experience.SetRange("Applicant No.", "Application No.");
                        Experience.SetRange(Industry, Recruitment."Experience industry");
                        Experience.CalcSums("No. of Years");
                        NoOfYears := Experience."No. of Years";
                        ArrayHeading[i] := 'Work Experience';
                        if Recruitment."Minimum years of experience" <> 0 then begin
                            if NoOfYears >= MaxExperience then
                                ArrayValue[i] := 'Above' + ' ' + format(MaxExperience) + ' ' + 'Years'
                            else
                                ArrayValue[i] := format(Experience."No. of Years") + ' Years';
                        end
                        else
                            ArrayValue[i] := format(Experience."No. of Years") + ' Years';
                        i += 1;
                        Experience.Reset();
                        Experience.SetRange("Applicant No.", "Application No.");
                        Experience.SetRange(Industry, Recruitment."Experience industry");
                        if Experience.FindFirst() then begin
                            ArrayHeading[i] := Recruitment."Experience industry" + ' Industry';
                            ArrayValue[i] := 'Yes';
                            i += 1;
                        end
                        else begin
                            ArrayHeading[i] := Recruitment."Experience industry" + ' Industry';
                            ArrayValue[i] := 'No';
                            i += 1;
                        end;
                    end
                    else begin
                        ArrayHeading[i] := 'Work Experience';
                        Experience.Reset();
                        Experience.SetRange("Applicant No.", "Application No.");
                        Experience.CalcSums("No. of Years");
                        ArrayValue[i] := format(Experience."No. of Years");
                        i += 1;
                    end;
                end;
                ArrayHeading[i] := 'Outcome of Sifting';
                ArrayValue[i] := format("Outcome of Sifting");
                i += 1;
                ArrayHeading[i] := 'Reason';
                ArrayValue[i] := Reason;
                i += 1;
                ArrayHeading[i] := 'Comment';
                if Qualified then
                    ArrayValue[i] := 'Not shortlisted for further sifting'
                else
                    ArrayValue[i] := 'Shortlisted for further sifting';
                i += 1;
                ArrayHeading[i] := 'Observation';
                ArrayValue[i] := Observation;
                i += 1;
                ArrayHeading[i] := 'Psychometric Assessment';
                if "Enigma Score" = 0 then
                    ArrayValue[i] := 'Not assessed'
                else
                    ArrayValue[i] := format("Enigma Score");
                i += 1;
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
