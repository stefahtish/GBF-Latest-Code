report 50413 "Quarterly Perfomance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './QuarterlyPerfomanceReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Criteria Category"; "Criteria Category")
        {
            column(CritCode; Code)
            {
            }
            column(CriteriaDescription; Description)
            {
            }
            dataitem("Perfomance SubCriteria"; "Perfomance SubCriteria")
            {
                RequestFilterFields = TimeFrame;
                DataItemLink = "Criteria Code" = field(Code);

                column(SubCriteria_Code; Code)
                {
                }
                column(SubCriteria_Description; Description)
                {
                }
                column(Unit; Unit)
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
                column(QuarterTarget; QuarterTarget)
                {
                }
                column(QuarterCumulative; QuarterCumulative)
                {
                }
                column(QuarterActual; QuarterActual)
                {
                }
                column(QuarterACummulative; QuarterACummulative)
                {
                }
                dataitem(SubIndicators; "Perfomance Target SubIndicator")
                {
                    DataItemLink = "Criteria Code" = field("Criteria Code"), "Indicator Code" = field(Code);

                    column(Criteria_Code; "Criteria Code")
                    {
                    }
                    column(Code; Code)
                    {
                    }
                    column(Description; Description)
                    {
                    }
                    column(SQuarterTarget; SQuarterTarget)
                    {
                    }
                    column(SQuarterCumulative; SQuarterCumulative)
                    {
                    }
                    column(SQuarterActual; SQuarterActual)
                    {
                    }
                    column(SQuarterACummulative; SQuarterACummulative)
                    {
                    }
                    column(SQuarterRemrks; SQuarterRemrks)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        PSubIndicators: Record "Perfomance Target SubIndicator";
                        PActualHeader: Record "Perfomance Contract Actuals";
                        PActualLines: Record "Perfomance Actual Lines";
                    begin
                        SQuarterTarget := 0;
                        SQuarterCumulative := 0;
                        SQuarterActual := 0;
                        SQuarterRemrks := ' ';
                        PSubIndicators.SetRange(Code, SubIndicators.Code);
                        if PSubIndicators.FindFirst() then begin
                            if Quarter = Quarter::Q1 then begin
                                SQuarterTarget := PSubIndicators."Q1 Target";
                                SQuarterCumulative := PSubIndicators."Q1 Target";
                            end;
                            if Quarter = Quarter::Q2 then begin
                                SQuarterTarget := PSubIndicators."Q2 Target";
                                SQuarterCumulative := PSubIndicators."Q1 Target" + PSubIndicators."Q2 Target";
                            end;
                            if Quarter = Quarter::Q3 then begin
                                SQuarterTarget := PSubIndicators."Q3 Target";
                                SQuarterCumulative := PSubIndicators."Q1 Target" + PSubIndicators."Q2 Target" + PSubIndicators."Q3 Target";
                            end;
                            if Quarter = Quarter::Q4 then begin
                                SQuarterTarget := PSubIndicators."Q4 Target";
                                SQuarterCumulative := PSubIndicators."Q1 Target" + PSubIndicators."Q2 Target" + PSubIndicators."Q3 Target" + PSubIndicators."Q4 Target";
                            end;
                            PActualHeader.Reset();
                            PActualHeader.SetRange("Criteria Code", "Criteria Category".Code);
                            PActualHeader.SetRange(TimeFrame, TimeFrameFilter);
                            PActualHeader.SetRange(Quarter, Quarter);
                            PActualHeader.SetRange("SubCriteria Code", "Perfomance SubCriteria".Code);
                            if PActualHeader.FindFirst() then begin
                                PActualLines.Reset();
                                PActualLines.SetRange("Document No.", PActualHeader."Document No.");
                                PActualLines.SetRange("SubIndicator Code", PSubIndicators.Code);
                                if PActualLines.FindFirst() then begin
                                    SQuarterActual := PActualLines."Quarter Actual";
                                    SQuarterRemrks := PActualLines."Quarter Remarks";
                                end;
                            end;
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    PSubCriteria: Record "Perfomance SubCriteria";
                    PSubIndicators: Record "Perfomance Target SubIndicator";
                    PActualHeader: Record "Perfomance Contract Actuals";
                    PActualLines: Record "Perfomance Actual Lines";
                begin
                    QuarterTarget := 0;
                    QuarterActual := 0;
                    QuarterCumulative := 0;
                    PSubCriteria.SetRange(TimeFrame, TimeFrameFilter);
                    PSubCriteria.SetRange(Code, "Perfomance SubCriteria".Code);
                    if PSubCriteria.FindFirst() then begin
                        if Quarter = Quarter::Q1 then begin
                            QuarterTarget := PSubCriteria."Q1 Target";
                            QuarterCumulative := PSubCriteria."Q1 Target";
                        end;
                        if Quarter = Quarter::Q2 then begin
                            QuarterTarget := PSubCriteria."Q2 Target";
                            QuarterCumulative := PSubCriteria."Q1 Target" + PSubCriteria."Q2 Target";
                        end;
                        if Quarter = Quarter::Q3 then begin
                            QuarterTarget := PSubCriteria."Q3 Target";
                            QuarterCumulative := PSubCriteria."Q1 Target" + PSubCriteria."Q2 Target" + PSubCriteria."Q3 Target";
                        end;
                        if Quarter = Quarter::Q4 then begin
                            QuarterTarget := PSubCriteria."Q4 Target";
                            QuarterCumulative := PSubCriteria."Q1 Target" + PSubCriteria."Q2 Target" + PSubCriteria."Q3 Target" + PSubCriteria."Q4 Target";
                        end;
                    end;
                    PSubIndicators.Reset();
                    PSubIndicators.SetRange("Indicator Code", "Perfomance SubCriteria".Code);
                    if PSubIndicators.Find('-') then
                        repeat
                            PActualHeader.Reset();
                            PActualHeader.SetRange("Criteria Code", "Criteria Category".Code);
                            PActualHeader.SetRange(TimeFrame, TimeFrameFilter);
                            PActualHeader.SetRange(Quarter, Quarter);
                            PActualHeader.SetRange("SubCriteria Code", "Perfomance SubCriteria".Code);
                            if PActualHeader.FindFirst() then begin
                                PActualLines.Reset();
                                PActualLines.SetRange("Document No.", PActualHeader."Document No.");
                                PActualLines.SetRange("SubIndicator Code", PSubIndicators.Code);
                                if PActualLines.FindFirst() then QuarterActual := QuarterActual + PActualLines."Quarter Actual";
                            end;
                        until PSubIndicators.Next() = 0;
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
                    field(Quarter; Quarter)
                    {
                        OptionCaption = ',Quarter 1, Quarter 2,Quarter 3,Quarter 4';
                        ApplicationArea = All;
                    }
                    field(TimeFrameFilter; TimeFrameFilter)
                    {
                        Caption = 'TimeFrame';
                        TableRelation = "Time Frames"."Time Frame";
                        ApplicationArea = All;
                    }
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
    var
        myInt: Integer;
    begin
        if TimeFrameFilter = '' then Error('Timeframe must be indicated for this report');
        if Quarter = Quarter::" " then Error('Timeframe must be indicated for this report');
    end;

    var
        QuarterTarget: Decimal;
        QuarterCumulative: Decimal;
        QuarterActual: Decimal;
        QuarterACummulative: Decimal;
        Quarter: Option " ",Q1,Q2,Q3,Q4;
        TimeFrameFilter: Code[20];
        SQuarterTarget: Decimal;
        SQuarterCumulative: Decimal;
        SQuarterActual: Decimal;
        SQuarterACummulative: Decimal;
        SQuarterRemrks: Text[1000];
        QuarterCode: Code[20];
}
