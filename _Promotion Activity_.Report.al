report 50407 "Promotion Activity"
{
    DefaultLayout = Word;
    RDLCLayout = './PromotionPlan.rdl';
    WordLayout = './PromotionPlan.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(ResearchActivityPlan; "Research Activity Plan")
        {
            DataItemTableView = WHERE("Research Type" = filter(Export));

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
            column(Category; Category)
            {
            }
            column(Code; Code)
            {
            }
            column(CountyName; "County Name")
            {
            }
            column(Descriptionofactivity; "Description of activity")
            {
            }
            column(ExportActivityType; "Export Activity Type")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Othertypesofparticipants; "Other types of participants")
            {
            }
            column(Researchtype; "Research type")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(End_Date; "End Date")
            {
            }
            column(SubCountyName; "Sub-County Name")
            {
            }
            column(SupportActivityType; "Support Activity Type")
            {
            }
            column(TargetNumberofparticipants; "Target Number of participants")
            {
            }
            column(Typeofparticipants; "Type of participants")
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
            // column(Output; OutputTxt)
            // {
            // }
            // column(Recommendations; RecommendationTxt)
            // {
            // }
            column(Subcounty; Subcounty)
            {
            }
            column(Submitted; Submitted)
            {
            }
            column(Venue; Venue)
            {
            }
            column(Actual_Number_of_participants; "Actual Number of participants")
            {
            }
            column(Actual_Venue; "Actual Venue")
            {
            }
            column(Town; Town)
            {
            }
            dataitem("Partnerships Activity Line"; "Partnerships Activity Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where("Patnership line type" = CONST(Objectives));

                column(Description; Description)
                {
                }
                column(Outcome; Outcome)
                {
                }
                column(Quantification_of_outcome; "Quantification of outcome")
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
            trigger OnAfterGetRecord()
            var
            begin
                CalcFields(Conclusion);
                Conclusion.CreateInStream(InStrm);
                ConclusionBigTxt.Read(InStrm);
                ConclusionTxt := Format(ConclusionBigTxt);
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
}
