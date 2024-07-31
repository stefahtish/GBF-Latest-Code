report 50410 "Partnership Activity"
{
    DefaultLayout = Word;
    RDLCLayout = './PartnershipPlan.rdl';
    WordLayout = './PartnershipPlan.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(PartnershipsActivityPlan; "Partnerships Activity Plan")
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
            column(CountyName; "County Name")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Morethanonecountry; "More than one country")
            {
            }
            column(Nameofpartnership; "Name of partnership")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(SubCountyName; "Sub-County Name")
            {
            }
            column(Budget; Budget)
            {
            }
            column(Code; Code)
            {
            }
            column(Conclusion; ConclusionTxt)
            {
            }
            column(Country; Country)
            {
            }
            column(County; County)
            {
            }
            column(Local; Local)
            {
            }
            column(Output; OutputTxt)
            {
            }
            column(Subcounty; Subcounty)
            {
            }
            column(Submitted; Submitted)
            {
            }
            column(Venue; Venue)
            {
            }
            column(Town; Town)
            {
            }
            column(Budgeted_Amount; "Budgeted Amount")
            {
            }
            column(ImplCounties; ImplCounties)
            {
            }
            dataitem(ActivitiesLines; "Partnerships Activity Line")
            {
                DataItemLink = code = field(code);
                DataItemTableView = where("Patnership line type" = filter(Activities));

                column(Patnership_line_type; "Patnership line type")
                {
                }
                column(Activities; Description)
                {
                }
                column(Date_Held; "Date Held")
                {
                }
                column(Venue_Lines; Venue)
                {
                }
                column(County_Name; "County Name")
                {
                }
                column(Outcome_Lines; Outcome)
                {
                }
            }
            dataitem(PartnersLines; "Partnerships Activity Line")
            {
                DataItemLink = code = field(code);
                DataItemTableView = where("Patnership line type" = filter(Patners));

                column(Partners; Description)
                {
                }
                column(Roles; Roles)
                {
                }
            }
            dataitem(PartnersFunding; "Partnerships Activity Line")
            {
                DataItemLink = code = field(code);
                DataItemTableView = where("Patnership line type" = filter(Patners));

                column(Names; Description)
                {
                }
                column(Budgetary_Plan; "Budgetary Plan")
                {
                }
            }
            dataitem("Recommendations"; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Recommendations));

                column(Recommendation; Description)
                {
                }
            }
            dataitem(ObjectivesLines; "Partnerships Activity Line")
            {
                DataItemLink = code = field(code);
                DataItemTableView = where("Patnership line type" = filter(Objectives));

                column(Objectives; Description)
                {
                }
                column(Outcome; Outcome)
                {
                }
                column(Quantification_of_outcome; "Quantification of outcome")
                {
                }
            }
            // dataitem("Patnership Location"; "Patnership Location2")
            // {
            //     DataItemLink = code = field(code);
            //     column(Country_Partner; Country)
            //     {
            //     }
            // }
            trigger OnAfterGetRecord()
            var
                Counties: Record "Patnership Location2";
                i: Integer;
            begin
                CalcFields(Conclusion);
                Conclusion.CreateInStream(InStrm);
                ConclusionBigTxt.Read(InStrm);
                ConclusionTxt := Format(ConclusionBigTxt);
                Counties.SetRange(Code, Code);
                if Counties.FindSet(false, false) then begin
                    i := 1;
                    repeat
                        if i = 1 then
                            ImplCounties := Counties.County
                        else
                            ImplCounties := ImplCounties + ', ' + Counties.County;
                        i := i + 1;
                    until Counties.Next() = 0;
                end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        InStrm: InStream;
        OutStrm: OutStream;
        OutputBigTxt: BigText;
        OutputTxt: Text;
        RecommendationBigTxt: BigText;
        RecommendationTxt: Text;
        ConclusionBigTxt: BigText;
        ConclusionTxt: Text;
        ImplCounties: Text;
}
