report 50423 "Perfomance Contract Matrix"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PerfomanceContractMatrix.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Criteria Category"; "Criteria Category")
        {
            column(Code; Code)
            {
            }
            column(Description; Description)
            {
            }
            dataitem("Perfomance SubCriteria"; "Perfomance SubCriteria")
            {
                DataItemLink = "Criteria Code" = field(Code);
                RequestFilterFields = TimeFrame;

                column(SubCriteria_Code; Code)
                {
                }
                column(SubCriteria_Description; Description)
                {
                }
                column(TimeFrame; TimeFrame)
                {
                }
                column(Weight; Weight)
                {
                }
                column(Annual__Target; "Annual  Target")
                {
                }
                column(PreviousYear; PreviousYear)
                {
                }
                column(PreviousYearTarget; PreviousYearTarget)
                {
                }
                trigger OnAfterGetRecord()
                var
                    PrevYearCriteria: Record "Perfomance SubCriteria";
                    TimeFrames: Record "Time Frames";
                    TimeFrames2: Record "Time Frames";
                begin
                    TimeFrames.Reset();
                    TimeFrames.SetRange("Time Frame", TimeFrame);
                    if TimeFrames.FindFirst() then CurrDate := TimeFrames."Start Date";
                    PrevYearDate := CalcDate('-1Y', CurrDate);
                    TimeFrames2.Reset();
                    TimeFrames2.SetRange("Start Date", PrevYearDate);
                    if TimeFrames2.FindFirst() then begin
                        PrevYearCriteria.Reset();
                        PrevYearCriteria.SetRange("Criteria Code", "Criteria Code");
                        PrevYearCriteria.SetRange(Code, Code);
                        PrevYearCriteria.SetRange(TimeFrame, TimeFrames2."Time Frame");
                        if PrevYearCriteria.FindFirst() then begin
                            PreviousYear := PrevYearCriteria.TimeFrame;
                            PreviousYearTarget := PrevYearCriteria."Annual  Target";
                        end;
                    end;
                end;
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
    var
        PreviousYear: Code[20];
        CurrDate: Date;
        PrevYearDate: Date;
        PreviousYearTarget: Decimal;
}
